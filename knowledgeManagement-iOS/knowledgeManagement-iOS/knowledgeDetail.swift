//
//  knowledgeDetail.swift
//  knowledgeManagement-iOS
//
//  Created by 松本唯尊 on 2020/09/29.
//  Copyright © 2020 松本唯尊. All rights reserved.
//

import UIKit
import CoreData

class knowledgeDetail: UIViewController, UITextViewDelegate, UITextFieldDelegate {

  @IBOutlet weak var knowledgeTitle: UITextField!
  @IBOutlet weak var knowledgeType: UITextField!
  @IBOutlet weak var knowledgeCreate: UITextField!
  @IBOutlet weak var knowledgeWhatKnowledge: UITextView!
  @IBOutlet weak var knowledgeHowKnowledge: UITextView!
  @IBOutlet weak var knowledgeUrl: UITextField!
  @IBOutlet weak var LocalSaveButton: UIButton!
  @IBOutlet weak var DockerSaveButton: UIButton!
  
  //LocalDataかコンテナ上データか判断するフラグ(Local=True、Docker=False)
  var dataPlace:Bool = false
  
  var knowledge = knowledgeDetail.newKnowledge()

  private static var delegate = (UIApplication.shared.delegate as? AppDelegate)
  private static var persistentContainer:NSPersistentContainer! = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
  
  //CoreDataのインスタンスを生成する(Knowledge)
  static func newKnowledge() -> Knowledge{
    let context = persistentContainer.viewContext
    let knowledge = NSEntityDescription.insertNewObject(forEntityName: "Knowledge", into: context) as! Knowledge
    return knowledge
  }
  
  //CoreDataのインスタンスを生成する(Local_Knowledge)
  static func newLocalKnowledge() -> Local_Knowledge{
    let context = persistentContainer.viewContext
    let Localknowledge = NSEntityDescription.insertNewObject(forEntityName: "Local_Knowledge", into: context) as! Local_Knowledge
    return Localknowledge
  }
  
    override func viewDidLoad() {
      super.viewDidLoad()
      print(knowledge.id)
      knowledgeTitle.text = self.knowledge.knowledge_subject
      knowledgeType.text = self.knowledge.type
      let dateFormatter = DateFormatter()
      // フォーマット設定®mat = "yyyyMMddHHmmss"
      // 変換
      if(self.knowledge.create_date != nil){
        let str = dateFormatter.string(from: self.knowledge.create_date!)
        knowledgeCreate.text = str
      }
      knowledgeHowKnowledge.text = self.knowledge.how_knowledge
      knowledgeWhatKnowledge.text = self.knowledge.what_knowledge
      if(self.knowledge.reference_url != nil){
        do{
          print(self.knowledge.reference_url)
//          knowledgeUrl.text = try String(contentsOf: self.knowledge.reference_url!)
//          knowledgeUrl.text = try String(contentsOf: self.knowledge.reference_url!)
          knowledgeUrl.text = self.knowledge.reference_url?.absoluteString
        }catch{
          print("URL変換エラー！！")
        }
      }
      if(dataPlace == false){
        print("Dockerデータ!!")
      }else{
        print("Localデータ!!")
      }
      if(dataPlace == false){
        LocalSaveButton.isEnabled = false
      }
      
      knowledgeWhatKnowledge.delegate = self
      knowledgeHowKnowledge.delegate = self
      knowledgeUrl.delegate = self
      
      //WhatKnowledgeのTextViewの枠線
      self.knowledgeWhatKnowledge.layer.borderColor = UIColor.lightGray.cgColor
      self.knowledgeWhatKnowledge.layer.borderWidth = 0.8
      self.knowledgeWhatKnowledge.layer.cornerRadius = 5

      //HowKnowledgeのTextViewの枠線
      self.knowledgeHowKnowledge.layer.borderColor = UIColor.lightGray.cgColor
      self.knowledgeHowKnowledge.layer.borderWidth = 0.8
      self.knowledgeHowKnowledge.layer.cornerRadius = 5
    }
    
  @IBAction func NewButtonTap(){
    print(knowledge)
    knowledgeDetail.save()
    self.performSegue(withIdentifier: "toKnowledgeManagement", sender: nil)
  }
  
  @IBAction func NewLocalSaveButtonTap(){
    var Localknowledge = knowledgeDetail.newLocalKnowledge()
    Localknowledge.knowledge_subject = knowledgeTitle.text
    Localknowledge.type = knowledgeType.text
    //Localknowledge.create_date = knowledgeCreate.text
    Localknowledge.how_knowledge = knowledgeHowKnowledge.text
    Localknowledge.what_knowledge = knowledgeWhatKnowledge.text
//    Localknowledge.reference_url = self.knowledge.reference_url
    Localknowledge.reference_url = URL(string: knowledgeUrl.text!)
    print(Localknowledge.reference_url)
    print(Localknowledge)
    knowledgeDetail.save()
    self.performSegue(withIdentifier: "toKnowledgeManagement", sender: nil)
  }
  
  @IBAction func BackButtonTap(){
//    self.performSegue(withIdentifier: "toKnowledgeManagement", sender: nil)
    dismiss(animated: true, completion: nil)
  }
  
  static func save(){
        delegate?.saveContext()
  }
  
  //textFieldでキーボードを閉じる
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    knowledgeTitle.resignFirstResponder()
    knowledgeType.resignFirstResponder()
    knowledgeCreate.resignFirstResponder()
    knowledgeWhatKnowledge.resignFirstResponder()
    knowledgeHowKnowledge.resignFirstResponder()
    knowledgeUrl.resignFirstResponder()
  }
}
