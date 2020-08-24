import { TestBed } from '@angular/core/testing';

import { SenderTypeService } from './sender-type.service';

describe('SenderTypeService', () => {
  let service: SenderTypeService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(SenderTypeService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
