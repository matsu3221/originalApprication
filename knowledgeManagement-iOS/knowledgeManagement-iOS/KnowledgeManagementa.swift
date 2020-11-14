//
//  KnowledgeManagement.swift
//  knowledgeManagement-iOS
//
//  Created by 松本唯尊 on 2020/08/29.
//  Copyright © 2020 松本唯尊. All rights reserved.
//

import UIKit
import SideMenu

class KnowledgeManagementa: UITableViewController,UITableViewDelegate,UITableViewDataSource {
  
//  @IBOutlet weak var KnowledgeSubject: UILabel!
//  @IBOutlet weak var KnowledgeType: UILabel!
  
  var objects:[[String:Any]] = []
  var KnowledgeTableView:  UITableView!
  
  let selectURL:URL = URL(string: "http://localhost:8080/knowledgeAccess/all")!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      KnowledgeTableView.delegate = self
      KnowledgeTableView.dataSource = self

      // サイドバーメニューからの通知を受け取る
      NotificationCenter.default.addObserver(
          self,
          selector: #selector(catchSelectMenuNotification(notification:)),
          name: Notification.Name("SelectMenuNotification"),
          object: nil
      )
    }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return objects.count
  }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

      let cell = tableView.dequeueReusableCell(withIdentifier: "KnowledgeCell", for: indexPath) as! UITableViewCell

      cell.KnowledgeSubject.text = objects[indexPath.count]["subject"]

  //    if(objects != nil){
  //    }
      return cell
    }
  
  @objc func catchSelectMenuNotification(notification: Notification) -> Void {
      // メニューからの返り値を取得
    let data:String = notification.userInfo!["selectMenu"] as! String // 返り値が格納されている変数
    if(data == "ALL"){
        // 実行したい処理を記述する
      let request = URLRequest(url: self.selectURL)
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
              print(self.objects[0]["howKnowledge"])
            } catch let error {
                print(error)
            }
          }
      }.resume()
    }
      print(data)
  }
  
  @IBAction func screenTap(){
    let menu = SideMenuManager.default.leftMenuNavigationController!
    present(menu, animated: true, completion: nil)
  }
  
}
