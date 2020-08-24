import { Component, OnInit } from '@angular/core';
import { knowledge } from '../../knowledge';
import { KnowledgeService } from '../../knowledge.service';
import { createKnowledge } from '../../createKnowledge';

@Component({
  selector: 'app-create-knowledge',
  templateUrl: './create-knowledge.component.html',
  styleUrls: ['./create-knowledge.component.css']
})
export class CreateKnowledgeComponent implements OnInit {

  knowledge:createKnowledge={
    knowledgeSubject:"",
    createDate:"",
    whatKnowledge:"",
    howKnowledge:"",
    referenceUrl:"",
    type:""
  }

  constructor(private knowledgeService:KnowledgeService) { }

  ngOnInit(): void {
  }

  onClickSaved(){
    this.knowledgeService.createKnowledge(this.knowledge);
    console.log("データを登録しました。")
    // this.knowledgeService.createKnowledge(this.knowledge);
  }
 
  onClickToday(){
    var now = new Date();
    console.log(now)
    this.knowledge.createDate = now.toISOString();
  }
}
