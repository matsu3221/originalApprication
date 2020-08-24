import { Component } from '@angular/core';
import { BreakpointObserver, Breakpoints } from '@angular/cdk/layout';
import { Observable } from 'rxjs';
import { map, shareReplay } from 'rxjs/operators';
import { AllKnowledgeComponent } from './all-knowledge/all-knowledge.component';
import { KnowledgeEditComponent } from './knowledge-edit/knowledge-edit.component';
import { SenderTypeService } from '../sender-type.service';

@Component({
  selector: 'app-sidenav',
  templateUrl: './sidenav.component.html',
  styleUrls: ['./sidenav.component.css']
})
export class SidenavComponent {

  isHandset$: Observable<boolean> = this.breakpointObserver.observe(Breakpoints.Handset)
    .pipe(
      map(result => result.matches),
      shareReplay()
    );

  constructor(
    private breakpointObserver: BreakpointObserver,
    private senderTypeService: SenderTypeService
  ) {}

  onClick(type){
    this.senderTypeService.setType(type);
  }
}
