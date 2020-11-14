import { Injectable } from '@angular/core';
import { knowledge } from './knowledge';
import { Observable, of } from 'rxjs';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { createKnowledge } from './createKnowledge';
import { editKnowledge } from './editKnowledge';
import { KeyedWrite } from '@angular/compiler';
import { withLatestFrom } from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class KnowledgeService {

  private knowledges:knowledge[]=[
  ]

  knowledgeR:knowledge = new knowledge();
  // private createKnowledge:createKnowledge;
  private knowledgeAllUrl = 'http://localhost:31081/knowledgeAccess/all';
  private knowledgeAllUrl_local = 'http://localhost:8080/knowledgeAccess/all';
  private knowledgeAddUrl = "http://localhost:31081/knowledgeAccess/add?knowledgeSubject={knowledgeSubject}&createDate={createDate}&whatKnowledge={whatKnowledge}&howKnowledge={howKnowledge}&referenceUrl={referenceUrl}&type={type}";
  private knowledgeAddUrl_local = "http://localhost:8080/knowledgeAccess/add?knowledgeSubject={knowledgeSubject}&createDate={createDate}&whatKnowledge={whatKnowledge}&howKnowledge={howKnowledge}&referenceUrl={referenceUrl}&type={type}";
  private knowledgeEditUrl = "http://localhost:31081/knowledgeAccess/edit?id={id}&knowledgeSubject={knowledgeSubject}&createDate={createDate}&whatKnowledge={whatKnowledge}&howKnowledge={howKnowledge}&referenceUrl={referenceUrl}&type={type}";
  private knowledgeEditUrl_local = "http://localhost:8080/knowledgeAccess/edit?id={id}&knowledgeSubject={knowledgeSubject}&createDate={createDate}&whatKnowledge={whatKnowledge}&howKnowledge={howKnowledge}&referenceUrl={referenceUrl}&type={type}";
  private knowledgeDeleteUrl_local = "http://localhost:8080/knowledgeAccess/delete?id={id}";


  constructor(private http: HttpClient) { }

  getKnowledges():Observable<knowledge[]>{
    // return of(this.knowledges);
    console.log(this.http.get<knowledge[]>(this.knowledgeAllUrl_local))
    return this.http.get<knowledge[]>(this.knowledgeAllUrl_local)
  }

  getKnowledge(knowledges,id):Observable<knowledge>{
    for(var i in knowledges){
      if(knowledges[i].id === id){
        this.knowledgeR = knowledges[i];
      }      
    }
    return of(this.knowledgeR);
  }

  deleteKnowledge(id){
    this.knowledgeDeleteUrl_local=this.knowledgeDeleteUrl_local.replace('{id}',id);
    // this.http.post<String>(this.knowledgeDeleteUrl_local, null);
    const req =  this.http.post<String>(this.knowledgeDeleteUrl_local, null);
    var message = req.subscribe();
    console.log(message);
    return "success!";
  }

  createKnowledge(knowledge:createKnowledge){
    const httpOptions = {
      headers: new HttpHeaders({
        'Content-Type':  'application/json',
      })
    };
    //ローカル用
    this.knowledgeAddUrl_local=this.knowledgeAddUrl_local.replace('{knowledgeSubject}',knowledge.knowledgeSubject);
    this.knowledgeAddUrl_local=this.knowledgeAddUrl_local.replace('{createDate}',knowledge.createDate);
    this.knowledgeAddUrl_local=this.knowledgeAddUrl_local.replace('{whatKnowledge}',knowledge.whatKnowledge);
    this.knowledgeAddUrl_local=this.knowledgeAddUrl_local.replace('{howKnowledge}',knowledge.howKnowledge);
    this.knowledgeAddUrl_local=this.knowledgeAddUrl_local.replace('{referenceUrl}',knowledge.referenceUrl);
    this.knowledgeAddUrl_local=this.knowledgeAddUrl_local.replace('{type}',knowledge.type);
    console.log(this.knowledgeAddUrl_local);
    const req =  this.http.post(this.knowledgeAddUrl_local, null);

    //サーバ用
    // this.knowledgeAddUrl=this.knowledgeAddUrl.replace('{knowledgeSubject}',knowledge.knowledgeSubject);
    // this.knowledgeAddUrl=this.knowledgeAddUrl.replace("{createDate}",knowledge.createDate);
    // this.knowledgeAddUrl=this.knowledgeAddUrl.replace('{whatKnowledge}',knowledge.whatKnowledge);
    // this.knowledgeAddUrl=this.knowledgeAddUrl.replace('{howKnowledge}',knowledge.howKnowledge);
    // this.knowledgeAddUrl=this.knowledgeAddUrl.replace('{referenceUrl}',knowledge.referenceUrl);
    // console.log(this.knowledgeAddUrl);
    // const req =  this.http.post<String>(this.knowledgeAddUrl, null);
    var message = req.subscribe();
    console.log(message);
    return "success!";
  } 
  
  editKnowledge(knowledge:editKnowledge){
    const httpOptions = {
      headers: new HttpHeaders({
        'Content-Type':  'application/json',
      })
    };
    //ローカル用
    this.knowledgeEditUrl_local=this.knowledgeEditUrl_local.replace('{id}',knowledge.id);
    this.knowledgeEditUrl_local=this.knowledgeEditUrl_local.replace('{knowledgeSubject}',knowledge.knowledgeSubject);
    this.knowledgeEditUrl_local=this.knowledgeEditUrl_local.replace('{createDate}',knowledge.createDate);
    this.knowledgeEditUrl_local=this.knowledgeEditUrl_local.replace('{whatKnowledge}',knowledge.whatKnowledge);
    this.knowledgeEditUrl_local=this.knowledgeEditUrl_local.replace('{howKnowledge}',knowledge.howKnowledge);
    this.knowledgeEditUrl_local=this.knowledgeEditUrl_local.replace('{referenceUrl}',knowledge.referenceUrl);
    this.knowledgeEditUrl_local=this.knowledgeEditUrl_local.replace('{type}',knowledge.type);
    console.log(this.knowledgeEditUrl_local);
    const req =  this.http.post(this.knowledgeEditUrl_local, null);

    //サーバ用
    // this.knowledgeAddUrl=this.knowledgeAddUrl.replace('{knowledgeSubject}',knowledge.knowledgeSubject);
    // this.knowledgeAddUrl=this.knowledgeAddUrl.replace("{createDate}",knowledge.createDate);
    // this.knowledgeAddUrl=this.knowledgeAddUrl.replace('{whatKnowledge}',knowledge.whatKnowledge);
    // this.knowledgeAddUrl=this.knowledgeAddUrl.replace('{howKnowledge}',knowledge.howKnowledge);
    // this.knowledgeAddUrl=this.knowledgeAddUrl.replace('{referenceUrl}',knowledge.referenceUrl);
    // console.log(this.knowledgeAddUrl);
    // const req =  this.http.post<String>(this.knowledgeAddUrl, null);
    var message = req.subscribe();
    console.log(message);
    return "success!";
  }  
}
