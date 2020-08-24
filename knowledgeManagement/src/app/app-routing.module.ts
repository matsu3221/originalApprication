import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { AllKnowledgeComponent } from './sidenav/all-knowledge/all-knowledge.component';
import { KnowledgeEditComponent } from './sidenav/knowledge-edit/knowledge-edit.component';
import { SidenavComponent } from './sidenav/sidenav.component';
import { CreateKnowledgeComponent } from './sidenav/create-knowledge/create-knowledge.component';

const routes: Routes = [
  { path: '', redirectTo: 'root', pathMatch: 'full' },
  { path: 'reload', redirectTo: 'root/all', pathMatch: 'full' },
  { path:'root', component: SidenavComponent, children:[  
    { path:'all', component: AllKnowledgeComponent,children:[
    { path:'edit/:id', component: KnowledgeEditComponent},
    { path:'create', component: CreateKnowledgeComponent}
    ]},
    { path:'all/:type', component: AllKnowledgeComponent, pathMatch: 'full'}
  ]},
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
