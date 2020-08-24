import { Injectable } from '@angular/core';
import { Router } from '@angular/router';

@Injectable({
  providedIn: 'root'
})
export class SenderTypeService {

  constructor(private router:Router) { 
  }

  private type;

  setType(type){
    console.log("type=" + type + "をセット")
    this.type = type;
  }

  getType(){
    let temp:string = this.type;
    // this.clearType();
    return temp;
  }

  clearType(){
    this.type = undefined;
  }
}
