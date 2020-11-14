//
//  KnowledgeCell.swift
//  knowledgeManagement-iOS
//
//  Created by 松本唯尊 on 2020/09/02.
//  Copyright © 2020 松本唯尊. All rights reserved.
//

import UIKit

class KnowledgeCell:UITableViewCell{
  @IBOutlet weak var KnowledgeSubject:UILabel!
  @IBOutlet weak var whatKnowledge: UITextView!
  @IBOutlet weak var referenceURL: UIWebView!
  @IBOutlet weak var webRequestButton: UIButton!
  @IBOutlet weak var typeImage: UIImageView!
  
  override func awakeFromNib() {
      super.awakeFromNib()

  }

  override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)

  }
}
