package com.spring_boot.example.sample;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;

import java.sql.Timestamp;

import javax.persistence.Id;

import java.util.Calendar;

@Entity
public class test {
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    private Integer id;

    private String name;

    private Timestamp timeStamp = new Timestamp(Calendar.getInstance().getTimeInMillis() - 1000*60*60*24);

    public Integer getId(){
        return id;
    }

    public void setId(Integer id){
        this.id = id;
    }

    public String getName(){
        return name;
    }

    public void setName(String name){
        this.name = name;
    }

    public Timestamp getTimestamp(){
        return timeStamp;
    }

    public void setTimestamp(Timestamp timeStamp){
        this.timeStamp = timeStamp;
    }

}