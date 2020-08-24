export class knowledge {
    id: number;
    knowledge_subject:string;
    createDate:string;
    howKnowledge:string;
    knowledgeSubject:string;
    recordCreateDate:string;
    recordUpdateDate:string;
    referenceUrl:string;
    whatKnowledge:string;
    type:string;

    constructor(){
        this.id = null;
        this.knowledge_subject = "";
        this.createDate = "";
        this.knowledgeSubject = "";
        this.howKnowledge = "";
        this.recordCreateDate = "";
        this.recordUpdateDate = "";
        this.referenceUrl = "";
        this.whatKnowledge = "";
        this.type = "";
    }
}