import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { AllKnowledgeComponent } from './all-knowledge.component';

describe('AllKnowledgeComponent', () => {
  let component: AllKnowledgeComponent;
  let fixture: ComponentFixture<AllKnowledgeComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ AllKnowledgeComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AllKnowledgeComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
