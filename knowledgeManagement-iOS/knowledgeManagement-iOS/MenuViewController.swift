//
//  MenuViewController.swift
//  knowledgeManagement-iOS
//
//  Created by 松本唯尊 on 2020/08/29.
//  Copyright © 2020 松本唯尊. All rights reserved.
//

import UIKit
import SideMenu

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
  
  private var tableView = UITableView();
  var items: [String] = ["ALL","プライベート","仕事"]

  override func viewDidLoad() {
      super.viewDidLoad()
      
    view.backgroundColor = .white
    
    self.navigationController?.navigationBar.tintColor = .clear
    self.navigationController?.navigationBar.barStyle = UIBarStyle.black
    self.navigationController?.navigationBar.isTranslucent = true
    self.navigationController?.navigationBar.backgroundColor = .blue
    
    tableView.frame = view.bounds
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    tableView.tableFooterView = UIView()
    view.addSubview(tableView)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
    cell.textLabel?.text = items[indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print(items[indexPath.row])
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SelectMenuNotification"), object: nil, userInfo: ["selectMenu": items[indexPath.row]])
    let kM = self.presentingViewController as! KnowledgeManagement
    kM.sidemenu = true
    kM.viewDidLoad()
    dismiss(animated: true, completion: nil)
    print(kM.toolBar.isHidden)
    kM.viewDidLoad()
    self.navigationController?.setToolbarHidden(false , animated: true)
    print(self.navigationController?.toolbar.isHidden)
  }
    
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    dismiss(animated: true, completion: nil)
    
    NotificationCenter.default.post(
      name: Notification.Name("SelectMenuNotification"),
      object: nil,
      userInfo: ["itemNo": indexPath.row]
    )
  }

}
