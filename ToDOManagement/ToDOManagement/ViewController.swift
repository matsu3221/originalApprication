//
//  ViewController.swift
//  ToDOManagement
//
//  Created by 松本唯尊 on 2020/07/02.
//  Copyright © 2020 松本唯尊. All rights reserved.
//

import UIKit

struct todoData: Decodable{
  let todoId: Int
  let todoName: String
  let description: String
  let todoDate: Date
  let yoken: String
  let recordCreateDate: Date
  let recordUpdateDate: Date
}

class ViewController: UIViewController {
  
  @IBOutlet weak var ResponseField: UITextView!
  @IBOutlet weak var todoId: UITextField!
  @IBOutlet weak var todoName: UITextField!
  @IBOutlet weak var description_todo: UITextField!
  @IBOutlet weak var todoDate: UITextField!
   
  var json = "no response"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    ResponseField.layer.borderColor = UIColor.blue.cgColor
    ResponseField.layer.borderWidth = 1.5
  }
  
  @IBAction func RequestButton(_ sender: Any) {
    let url = URL(string: "http://macbook.local:30220/todoAccess/all")
    let request = URLRequest(url: url!)
    let formatter: DateFormatter = DateFormatter()
    let task = URLSession.shared.dataTask(with: request){(data, response, error) in
      guard let data = data else { return }
      do{
        self.json = String(data: data, encoding: .utf8)!

        let todoDataArray = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as![Any]
        print(todoDataArray)
        let todoData = todoDataArray.map {(todoData) -> [String:Any] in
          return todoData as! [String:Any]
        }
        //レスポンスされたjsonをResponseFieldへ格納する
        DispatchQueue.main.sync {
          self.todoId.text = String(todoData[0]["todoId"] as! Int)
          self.todoName.text = todoData[0]["todoName"] as! String
          self.description_todo.text = todoData[0]["description"] as! String
//          self.todoDate.text = formatter.string(from: todoData[0]["todoDate"] as! Date)
          self.todoDate.text = todoData[0]["todoDate"] as! String
        }
      }catch let jsonError{
        print("error!", jsonError)
      }

    }
    task.resume()
  }
  
}
