//
//  KnowledgeManagement.swift
//  knowledgeManagement-iOS
//
//  Created by 松本唯尊 on 2020/09/02.
//  Copyright © 2020 松本唯尊. All rights reserved.
//

import UIKit
import SideMenu
import CoreData

class KnowledgeManagement: UIViewController,UITableViewDelegate,UITableViewDataSource, UIToolbarDelegate {
    
  var objects:[[String:Any]] = []
  var objects_swap:[[String:Any]] = []
  @IBOutlet weak var KnowledgeTableView: UITableView!
  //UIToolbar
  @IBOutlet weak var toolBar: UIToolbar!
  //  @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
//  @IBOutlet weak var WhatKLG: UITextView!
  
  //sidemenuからのデータ受け渡し
  var sidemenu:Bool = false
  
  private static var delegate = (UIApplication.shared.delegate as? AppDelegate)
  private static var persistentContainer:NSPersistentContainer! = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
  //選択されたセルのKnowledgeを格納する
  var selectKnowledge = KnowledgeManagement.newKnowledge()
  var Local_Knowledges:[Local_Knowledge] = []
  
  //TableViewの表示モードを変更する際に利用するフラグ(true=ローカルモード、false=サーバモード)
  //デフォルトはサーバモードとする
  var LocalMode:Bool = false
  
  //CoreDataのインスタンスを生成する
  static func newKnowledge() -> Knowledge{
    let context = persistentContainer.viewContext
    let knowledge = NSEntityDescription.insertNewObject(forEntityName: "Knowledge", into: context) as! Knowledge
    return knowledge
  }
  
  //CoreDataのインスタンスを生成する
    static func newLocal_Knowledge() -> Local_Knowledge{
      let context = persistentContainer.viewContext
      let Local_knowledge = NSEntityDescription.insertNewObject(forEntityName: "Local_Knowledge", into: context) as! Local_Knowledge
      return Local_knowledge
    }
  
  //特定のidのデータを取得する
  static func getKnowledge(id:Int) -> Bool{
    let perdicate = NSPredicate(format: "id == %@", NSNumber(value: id as Int))
    return self.getKnowledge(with: perdicate)
  }
  
  static func getKnowledge(with predicate: NSPredicate?) -> Bool{
    let context = persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Local_Knowledge")
    request.predicate = predicate
//    var local_Knowledge = newLocal_Knowledge()
    do{
      var local_Knowledge = try context.fetch(request) as! [Local_Knowledge]
      print(local_Knowledge.count)
      if(local_Knowledge.count == 0){
        return true
      }
      return false
    }catch{
      print("データ取得に失敗しました")
      fatalError()
    }
  }
  
  //iPhoneの場合のURL
  let selectURL_iPhone:URL = URL(string: "http://192.168.0.105:8080/knowledgeAccess/all")!
  //ローカル(MAC)の場合のURL
  let selectURL:URL = URL(string: "http://localhost:8080/knowledgeAccess/all")!
  
  override func viewDidLoad() {
      super.viewDidLoad()
      self.toolBar.delegate = self
      self.KnowledgeTableView.delegate = self
      self.KnowledgeTableView.dataSource = self
      self.KnowledgeTableView.isScrollEnabled = true
      // サイドバーメニューからの通知を受け取る
      NotificationCenter.default.addObserver(
        self,
        selector: #selector(catchSelectMenuNotification(notification:)),
        name: Notification.Name("SelectMenuNotification"),
        object: nil
      )
      if (TARGET_OS_SIMULATOR != 0){
        //simulator
        print(TARGET_OS_SIMULATOR)
        print("simulartor")
      }
      else{
        //Device
        print("Device")
      }
      self.view.addSubview(toolBar)
    self.navigationController?.setToolbarHidden(false , animated: true)
  }
    
  //セル数
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //サーバモードであった場合
    if(LocalMode == true){
      return self.Local_Knowledges.count
    }
    return self.objects.count
  }

  //セルの定義
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! KnowledgeCell
    cell.whatKnowledge.isEditable = false
    if(LocalMode == false){
      if(self.objects.count != 0){
        cell.whatKnowledge?.text = objects[indexPath.row]["whatKnowledge"] as! String
        cell.KnowledgeSubject?.text = objects[indexPath.row]["knowledgeSubject"] as! String
        if(objects[indexPath.row]["type"] as! String == "仕事"){
          cell.typeImage?.image = UIImage(named: "work_image")
        }else{
          cell.typeImage?.image = UIImage(named: "private_image")
        }
        print(objects[indexPath.row]["referenceUrl"])
        if(objects[indexPath.row]["referenceUrl"] != nil){
//          let urlRequest = NSURLRequest(url:objects[indexPath.row]["referenceUrl"] as! URL)
          do{
            let url = try URL(string:objects[indexPath.row]["referenceUrl"] as! String)
            if(url != nil){
              let urlRequest = NSURLRequest(url: url!)
//              cell.referenceURL.loadRequest(urlRequest as URLRequest)
            }
          }catch{
            print("URLのキャストミス")
          }
        }
      }else{
        cell.KnowledgeSubject?.text = nil
        cell.whatKnowledge?.text = nil
      }
    }else{
      if(self.Local_Knowledges.count != 0){
        print(indexPath.row)
        cell.whatKnowledge?.text = Local_Knowledges[indexPath.row].what_knowledge
        cell.KnowledgeSubject?.text = Local_Knowledges[indexPath.row].knowledge_subject
        if(Local_Knowledges[indexPath.row].type == "仕事"){
          cell.typeImage?.image = UIImage(named: "work_image")
        }else{
          cell.typeImage?.image = UIImage(named: "private_image")
        }
        if(Local_Knowledges[indexPath.row].reference_url != nil){
          let urlRequest = NSURLRequest(url:Local_Knowledges[indexPath.row].reference_url as! URL)
//          cell.referenceURL.loadRequest(urlRequest as URLRequest)
        }
      }else{
        cell.KnowledgeSubject?.text = nil
        cell.whatKnowledge?.text = nil
      }
    }
      return cell
  }
   
  //セルの高さ
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 400
  }
  
    @objc func catchSelectMenuNotification(notification: Notification) -> Void {
      // メニューからの返り値を取得
      let selectMenu:String = notification.userInfo!["selectMenu"] as! String // 返り値が格納されている変数
//      if(data == "ALL"){
        let request:URLRequest
        // 実行したい処理を記述する
        if(TARGET_OS_SIMULATOR != 0){
          request = URLRequest(url: self.selectURL)
        }else{
          request = URLRequest(url: self.selectURL_iPhone)
        }
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
          if error == nil, let data = data, let response = response as? HTTPURLResponse {
              // HTTPヘッダの取得
              print("Content-Type: \(response.allHeaderFields["Content-Type"] ?? "")")
              // HTTPステータスコード
              print("statusCode: \(response.statusCode)")
              do {
                  let object = try JSONSerialization.jsonObject(with: data, options: [])  // DataをJsonに変換
                self.objects = object as! [[String:Any]]
                print("object is")
                print(self.objects[0]["type"])
                if(selectMenu != "ALL"){
                  self.objects_swap = self.objects
                  self.objects.removeAll()
                  print("テスト")
                  //Swap処理回数
                  var i:Int = 0
                  var resetFlag:Bool = false
                  print(self.objects_swap.count)
                  while(self.objects_swap.count > i){
                    if(self.objects_swap[i]["type"] as! String != selectMenu){
                      print(i)
                      self.objects_swap.remove(at: i)
                      i = 0
                      resetFlag = true
                    }
                    if(resetFlag == false){
                      i = i + 1
                    }
                    resetFlag = false
                  }
                  self.objects = self.objects_swap
                }
                DispatchQueue.main.sync {
                  //TableViewをサーバモードに変更
                  self.LocalMode = false
                  self.KnowledgeTableView.reloadData()
                  self.view.layoutIfNeeded()
                  self.view.updateConstraints()
                    return
                }
              } catch let error {
                  print(error)
              }
            }
        }.resume()
//      }
      self.view.addSubview(toolBar)
    }
  
  //セルのスワイプアクション
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if(Local_Knowledges[indexPath.row].knowledge_subject != nil){
      if(LocalMode == true){
        let context = KnowledgeManagement.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Local_Knowledge")
        print(Local_Knowledges[indexPath.row].knowledge_subject)
        request.predicate = NSPredicate(format: "knowledge_subject=%@", Local_Knowledges[indexPath.row].knowledge_subject as! String)
        do{
          let deleteRequests = try context.fetch(request)
          for myData in deleteRequests{
            context.delete(myData as! NSManagedObject)
          }
        }catch let error as NSError{
          print("データ削除に失敗しました")
        }
      }else{
        print("サーバ処理の場合")
      }
        // 先にデータを削除しないと、エラーが発生します。
      self.Local_Knowledges.remove(at: indexPath.row)
      KnowledgeTableView.deleteRows(at: [indexPath], with: .automatic)
    }
  }

  //画面がback、popViewControllerで戻ってきたときの再描写
  override func viewWillAppear(_ animated: Bool) {
      self.KnowledgeTableView.reloadData()
  }
  
  //サイドメニューを開くメソッド
  @IBAction func screenTap(){
    let menu = SideMenuManager.default.leftMenuNavigationController!
    present(menu, animated: true, completion: nil)
  }
  
  //Localにデータを保存する
  @IBAction func saveTap(){
    //var knowledges:[Knowledge] = []
    print(objects.count)
    var saveCount = 0
    while objects.count > saveCount{
//      let knowledge = KnowledgeManagement.newLocal_Knowledge()
      var save_Flag = KnowledgeManagement.getKnowledge(id: objects[saveCount]["id"] as! Int)
      print(save_Flag)
      //対象idのKnowledgeが登録されているか判定する
      //存在しない場合はデータを保存する
      if(save_Flag){
        var save_Knowledge = KnowledgeManagement.newLocal_Knowledge()
        save_Knowledge.id = objects[saveCount]["id"] as! Int64
        print(objects[saveCount]["id"])
        save_Knowledge.how_knowledge = objects[saveCount]["howKnowledge"] as? String
        save_Knowledge.knowledge_subject = objects[saveCount]["knowledgeSubject"] as? String
        save_Knowledge.reference_url = URL(string: objects[saveCount]["referenceUrl"] as! String)
        save_Knowledge.type = objects[saveCount]["type"] as? String
        save_Knowledge.what_knowledge = objects[saveCount]["whatKnowledge"] as? String
        KnowledgeManagement.save()
      }
      saveCount = saveCount + 1
    }
    //KnowledgeManagement.save()
  }
  
  static func save(){
    delegate?.saveContext()
  }
  
  //LocalDataを読み込む際に利用
  @IBAction func tapGetData(){
    if(self.Local_Knowledges.count != 0){
      self.Local_Knowledges = []
    }
    self.Local_Knowledges = []
    self.Local_Knowledges = KnowledgeManagement.getKnowledges()
    self.LocalMode = true
    self.KnowledgeTableView.reloadData()
  }
    
  //データ参照
  static func getKnowledges() -> [Local_Knowledge] {
      let context = persistentContainer.viewContext
      let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Local_Knowledge")
      do {
          let Local_Knowledges = try context.fetch(request) as! [Local_Knowledge]
          return Local_Knowledges
      }
      catch {
          fatalError()
      }
  }
  
  //新規Knowledge作成画面への遷移
  @IBAction func NewButtonTap(){
    self.performSegue(withIdentifier: "toKnowledge", sender: 0)
  }
  
  //画面遷移時の処理
  override func prepare(for segue: UIStoryboardSegue,sender: Any?){
    if segue.identifier == "toKnowledge"{
      let nextVC = segue.destination as! knowledgeDetail
      nextVC.knowledge = self.selectKnowledge as! Knowledge
      if(sender as! Int == 0){
        nextVC.dataPlace = true
      }else{
        nextVC.dataPlace = false
      }
    }
  }
  
  // Cell が選択された場合
  func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
    //Localかサーバか(0=Local、1=サーバ)
    var LocalData:Int = 0
    if(LocalMode == false){
      self.selectKnowledge.id = objects[indexPath.row]["id"] as! Int64
      self.selectKnowledge.how_knowledge = objects[indexPath.row]["howKnowledge"] as? String
      self.selectKnowledge.knowledge_subject = objects[indexPath.row]["knowledgeSubject"] as? String
      self.selectKnowledge.reference_url = URL(string: objects[indexPath.row]["referenceUrl"] as! String)
      self.selectKnowledge.type = objects[indexPath.row]["type"] as? String
      self.selectKnowledge.what_knowledge = objects[indexPath.row]["whatKnowledge"] as? String
//      LocalData = 1
    }else{
      self.selectKnowledge.id = Local_Knowledges[indexPath.row].id
      self.selectKnowledge.how_knowledge = Local_Knowledges[indexPath.row].how_knowledge
      self.selectKnowledge.knowledge_subject = Local_Knowledges[indexPath.row].knowledge_subject
      self.selectKnowledge.reference_url = Local_Knowledges[indexPath.row].reference_url
      self.selectKnowledge.type = Local_Knowledges[indexPath.row].type
      self.selectKnowledge.what_knowledge = Local_Knowledges[indexPath.row].what_knowledge
    }
    performSegue(withIdentifier: "toKnowledge",sender: LocalData)
  }
  
  //セル内のWEBボタンを押下した際の処理
  @IBAction func webRequestButtonTap(_ sender: AnyObject) {
    var btn = sender as! UIButton
    var cell = btn.superview?.superview as! KnowledgeCell
    var row:Int = KnowledgeTableView.indexPath(for: cell)!.row
    if(LocalMode == false){
      print("Server")
      print(row)
      print(objects[row]["howKnowledge"])
      do{
        let url = try URL(string:objects[row]["referenceUrl"] as! String)
        if(url != nil){
          let urlRequest = NSURLRequest(url: url!)
          cell.referenceURL.loadRequest(urlRequest as URLRequest)
        }
      }catch{
        print("URLのキャストミス")
      }
    }else{
      print("Local")
      print(row)
      print(Local_Knowledges[row].how_knowledge)
      if(Local_Knowledges[row].reference_url != nil){
        let urlRequest = NSURLRequest(url:Local_Knowledges[row].reference_url as! URL)
        cell.referenceURL.loadRequest(urlRequest as URLRequest)
      }
    }
  }
  
}
