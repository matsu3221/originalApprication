package com.todo.todoAccess;

import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class todo {
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    private Integer todoId;

    //todoの名前
    private String todoName;

    //todoの説明
    private String description;

    //todo実行日
    private Date todoDate;

    //仕事なのかプライベートなのか(アプリ上はリストをイメージ)
    private String yoken;

    //作った日
    private Timestamp recordCreateDate = new Timestamp(Calendar.getInstance().getTimeInMillis() - 1000*60*60*24);

    //更新した日
    private Timestamp recordUpdateDate = new Timestamp(Calendar.getInstance().getTimeInMillis() - 1000*60*60*24);

    public Integer getTodoId(){
        return todoId;
    }

    public void setTodoId(Integer Id){
        this.todoId = Id;
    }

    public String getTodoName(){
        return todoName;
    }


    public void setTodoName(String todoName){
        this.todoName = todoName;
    }

    public String getDescription(){
        return description;
    }

    public void setDescription(String description){
        this.description = description;
    }

    public Date getTodoDate(){
        return todoDate;
    }

    public void setTodoDate(Date todoDate){
        this.todoDate = todoDate;
    }

    public String getYoken(){
        return yoken;
    }

    public void setYoken(String yoken){
        this.yoken = yoken;
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