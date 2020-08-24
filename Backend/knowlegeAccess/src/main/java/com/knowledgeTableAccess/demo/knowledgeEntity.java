package com.knowledgeTableAccess.demo;

import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class knowledgeEntity {
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    private Integer id;
    private String knowledgeSubject;
    private Date createDate;
    private String whatKnowledge;
    private String howKnowledge;
    private String referenceUrl;
    private Timestamp recordCreateDate = new Timestamp(Calendar.getInstance().getTimeInMillis() - 1000*60*60*24);
    private Timestamp recordUpdateDate = new Timestamp(Calendar.getInstance().getTimeInMillis() - 1000*60*60*24);

    public Integer getId(){
        return id;
    }

    public void seId(Integer id){
        this.id = id;
    }

    public String getKnowledgeSubject(){
        return knowledgeSubject;
    }

    public void setKnowledgeSubject(String knowledgeSubject){
        this.knowledgeSubject = knowledgeSubject;
    }

    public Date getCreateDate(){
        return createDate;
    }

    public void setCreateDate(Date createDate){
        this.createDate = createDate;
    }

    public String getWhatKnowledge(){
        return whatKnowledge;
    }

    public void setWhatKnowledge(String whatKnowledge){
        this.whatKnowledge = whatKnowledge;
    }

    public String getHowKnowledge(){
        return howKnowledge;
    }

    public void setHowKnowledge(String howKnowledge){
        this.howKnowledge = howKnowledge;
    }

    public String getReferenceUrl(){
        return referenceUrl;
    }

    public void setReferenceUrl(String referenceUrl){
        this.referenceUrl = referenceUrl;
    }

    public Timestamp getRecordCreateDate(){
        return recordCreateDate;
    }

    public void setRecordCreateDate(Timestamp recordCreateDate){
        this.recordCreateDate= recordCreateDate;
    }

    public Timestamp getRecordUpdateDate(){
        return recordUpdateDate;
    }

    public void setRecordUpdateDate(Timestamp recordUpdateDate){
        this.recordUpdateDate= recordUpdateDate;
    }
}
