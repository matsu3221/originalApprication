package com.knowledgeTableAccess.accessdataknowledge;

public class resquestKnowledge {
    // private Integer id;
    private String knowledgeSubject;
    private String createdate;
    private String howKnowledge;
    private String referenceUrl;
    private String whatKnowledge;

    // public Integer getId(){
    //     return this.id;
    // }

    // public void setId(Integer id){
    //     this.id = id;
    // }

    public String getKnowledgeSubject(){
        return this.knowledgeSubject;
    }

    public void setKnowledgeSubject(String knowledgeSubject){
        this.knowledgeSubject = knowledgeSubject;
    }

    public String getCreatedate(){
        return this.createdate;
    }

    public void setCreatedate(String createdate){
        this.createdate = createdate;
    }

    public String getHowKnowledge(){
        return this.howKnowledge;
    }

    public void setHowKnowledge(String howKnowledge){
        this.howKnowledge = howKnowledge;
    }

    public String getReferenceUrl(){
        return this.referenceUrl;
    }

    public void setReferenceUrl(String referenceUrl){
        this.referenceUrl = referenceUrl;
    }

    public String getWhatKnowledge(){
        return this.whatKnowledge;
    }

    public void setWhatKnowledge(String whatKnowledge){
        this.whatKnowledge = whatKnowledge;
    }
}