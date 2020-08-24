import { Component, OnInit, ChangeDetectorRef, Input} from '@angular/core';
import { knowledge } from '../../knowledge';
import { KnowledgeService } from '../../knowledge.service';
import { SelectMultipleControlValueAccessor } from '@angular/forms';
import { ActivatedRoute, ParamMap } from '@angular/router';
import { SenderTypeService } from '../../sender-type.service';

@Component({
  selector: 'app-all-knowledge',
  templateUrl: './all-knowledge.component.html',
  styleUrls: ['./all-knowledge.component.css']
})
export class AllKnowledgeComponent implements OnInit {

  /**
  *@param activatedRoute ActivatedRoute
  */

  knowledges:knowledge[]=[];
  knowledgesType:knowledge[]=[];
  type:string=this.senderTypeService.getType();

  constructor(
    private knowledgeService:KnowledgeService,
    private changeDetectorRef:ChangeDetectorRef,
    private activatedRoute:ActivatedRoute,
    private senderTypeService:SenderTypeService
  ) { }

  ngOnInit(): void {
    console.log("データを取得します。")
    this.getKnowledges();
    if(this.type === undefined){
      this.type = "ALL";
    }
    console.log(this.type);
  }

  getKnowledges(): void{
    this.knowledgeService.getKnowledges().subscribe(knowledges => 
        sessionStorage.setItem('knowledges',JSON.stringify(knowledges)
      ));
    var knowledge_string = sessionStorage.getItem("knowledges");
    this.knowledges = JSON.parse(knowledge_string);
    if(this.type != null){
      var i = 0;
      var j = 0;
      console.log(this.knowledges.length);
      while(this.knowledges.length > i){
        console.log(this.knowledges[i].type);
        if(this.knowledges[i].type === this.type){
          console.log("セット:" + this.knowledges[i].id)
          this.knowledgesType[j] = this.knowledges[i];
          j++;
        }
        i++;
      }
      console.log(this.knowledgesType);
      this.knowledges = this.knowledgesType;
    }
  }

  onClickDelete(id){
      this.knowledgeService.deleteKnowledge(id);
    setTimeout(() => {
      console.log("再描画します。");
      this.ngOnInit();
      console.log(this.knowledges);
      location.reload()
    },3000);
  }
}
