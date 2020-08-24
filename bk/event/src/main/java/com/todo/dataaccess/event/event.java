package com.todo.dataaccess.event;


import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

import java.util.Calendar;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class event {
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    private Integer no;

    private String name;

    private String space;

    private Date eventDate;

    private Timestamp recordUpdate = new Timestamp(Calendar.getInstance().getTimeInMillis() - 1000*60*60*24);

    public Integer getNo(){
        return no;
    }

    public void setNo(Integer no){
        this.no = no;
    }

    public String getName(){
        return name;
    }

    public void setName(String name){
        this.name = name;
    }

    public String getSpace(){
        return space;        
    }

    public void setSpace(String space){
        this.space = space;
    }

    public Date getEventDate(){
        return eventDate;        
    }

    public void setEventDate(String eventDateStr){
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try{
        this.eventDate = dateFormat.parse(eventDateStr);
        }catch(Exception e){
            System.out.println("データフォーマットが正しくありません。");
        }
    }


}