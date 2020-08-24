import { Component, OnInit } from '@angular/core';
import { KnowledgeService } from '../../knowledge.service';
import { knowledge } from 'src/app/knowledge';
import { ActivatedRoute, ParamMap } from '@angular/router';
import { editKnowledge } from '../../editKnowledge';

@Component({
  selector: 'app-knowledge-edit',
  templateUrl: './knowledge-edit.component.html',
  styleUrls: ['./knowledge-edit.component.css']
})
export class KnowledgeEditComponent implements OnInit {
  /**
  *@param activatedRoute ActivatedRoute
  */

  constructor(private knowledgeService:KnowledgeService,private activatedRoute:ActivatedRoute) { }

  knowledges:knowledge[];
  knowledge:knowledge;
  editKnowledge:editKnowledge={
    id:"",
    knowledgeSubject:"",
    createDate:"",
    whatKnowledge:"",
    howKnowledge:"",
    knowledge_subject:"",
    referenceUrl:"",
    type:""
  }
  id:string;
  id_int:number;

  ngOnInit(): void {
    this.getKnowledges();
    this.activatedRoute.paramMap.subscribe((params:ParamMap) => {
      this.id = params.get('id');
    });
    // console.log(this.id);
    this.id_int = parseInt(this.id);
    // console.log(this.id_int);
    this.getKnowledge(this.id_int);
    console.log(this.id);
    console.log(this.editKnowledge.id);
    this.editKnowledge.id = this.id;
  }

  getKnowledges(): void{
    this.knowledgeService.getKnowledges().subscribe(knowledges => this.knowledges = knowledges);
    console.log(this.knowledges);
  }

  getKnowledge(id_int): void{
    this.knowledges = JSON.parse(sessionStorage.getItem("knowledges"));
    console.log(this.knowledges)
    for(var num in this.knowledges){
      if(this.knowledges[num].id === id_int){
          this.knowledge = this.knowledges[num]
          console.log(this.knowledges[num].createDate)
          // console.log("対象は" + this.knowledges[num])
          // console.log("一致したのは" + this.knowledge.id)
      }
    }
  }

  onClickSaved(){
    this.editKnowledge.createDate = this.knowledge.createDate;
    this.editKnowledge.whatKnowledge = this.knowledge.whatKnowledge;
    this.editKnowledge.howKnowledge = this.knowledge.howKnowledge;
    this.editKnowledge.knowledgeSubject = this.knowledge.knowledgeSubject;
    this.editKnowledge.referenceUrl = this.knowledge.referenceUrl;
    this.editKnowledge.type = this.knowledge.type;
    this.knowledgeService.editKnowledge(this.editKnowledge);
  }

}
