package com.knowledgeTableAccess.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.CrossOrigin;

import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.Optional;

// import com.knowledgeTableAccess.demo.knowledgeRepository;

@Controller
@RequestMapping(path="/knowledgeAccess")
public class knowledgeController {
    @Autowired
    private knowledgeRepository knowledgeR;

    @CrossOrigin
    @PostMapping("/add")
    public @ResponseBody String addNewKnowledge(@RequestParam String knowledgeSubject,
    @RequestParam String createDate,@RequestParam String whatKnowledge, @RequestParam String howKnowledge,@RequestParam String referenceUrl){
        knowledgeEntity knowledgeE = new knowledgeEntity();
        Date knowledgeCreateDate  = new Date();
        knowledgeE.setKnowledgeSubject(knowledgeSubject);
        knowledgeE.setWhatKnowledge(whatKnowledge);
        knowledgeE.setHowKnowledge(howKnowledge);
        SimpleDateFormat createDateFormat = new SimpleDateFormat("yyyy/mm/dd hh:mm:ss");
        try{
            knowledgeCreateDate = createDateFormat.parse(createDate);
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        knowledgeE.setCreateDate(knowledgeCreateDate);
        knowledgeE.setReferenceUrl(referenceUrl);
        knowledgeR.save(knowledgeE);
        return "todo Add Success!!!";
    }

    @CrossOrigin 
    @GetMapping("/all")
    public @ResponseBody Iterable<knowledgeEntity> getAllTodo(){
        return knowledgeR.findAll();
    }

    @CrossOrigin
    @PostMapping("/edit")
    public @ResponseBody String editKnowledge(@RequestParam Integer id,@RequestParam String knowledgeSubject,
    @RequestParam String createDate,@RequestParam String whatKnowledge, @RequestParam String howKnowledge,@RequestParam String referenceUrl){
        Optional<knowledgeEntity> editData = knowledgeR.findById(id);
        Date knowledgeCreateDate  = new Date();
        knowledgeEntity editData_after = new knowledgeEntity();
        editData_after = editData.get();
        System.out.println(editData_after.getKnowledgeSubject());
        editData_after.setKnowledgeSubject(knowledgeSubject);
        editData_after.setWhatKnowledge(whatKnowledge);
        editData_after.setHowKnowledge(howKnowledge);
        SimpleDateFormat createDateFormat = new SimpleDateFormat("yyyy/mm/dd hh:mm:ss");
        try{
            knowledgeCreateDate = createDateFormat.parse(createDate);
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        editData_after.setCreateDate(knowledgeCreateDate);
        editData_after.setReferenceUrl(referenceUrl);
        knowledgeR.save(editData_after);
        return "Success";
    }
}