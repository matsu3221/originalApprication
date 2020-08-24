package com.knowledgeTableAccess.accessdataknowledge;

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

import com.knowledgeTableAccess.accessdataknowledge.knowledgeRepository;

@Controller
@RequestMapping(path="/knowledgeAccess")
public class knowledgeController {
    @Autowired
    private knowledgeRepository knowledgeR;

    @CrossOrigin
    @PostMapping("/add")
    public @ResponseBody void addNewKnowledge(@RequestParam("knowledgeSubject") String knowledgeSubject,
    @RequestParam String createDate,@RequestParam String whatKnowledge, @RequestParam String howKnowledge,@RequestParam String referenceUrl ,@RequestParam String type){
        knowledge knowledgeE = new knowledge();
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
        knowledgeE.setType(type);
        knowledgeR.save(knowledgeE);
        return;
    }

    @CrossOrigin
    @PostMapping("/delete")
    public @ResponseBody void knowledgeDelete(@RequestParam String id){
        Integer deleteId;
        deleteId = Integer.parseInt(id);
        knowledgeR.deleteById(deleteId);
        return;
    }

    @CrossOrigin
    @GetMapping("/all")
    public @ResponseBody Iterable<knowledge> getAllKnowledge(){
        return knowledgeR.findAll();
    }

    @CrossOrigin
    @PostMapping("/edit")
    public @ResponseBody void editKnowledge(@RequestParam Integer id,@RequestParam String knowledgeSubject,
    @RequestParam String createDate,@RequestParam String whatKnowledge, @RequestParam String howKnowledge,@RequestParam String referenceUrl,@RequestParam String type){
        Optional<knowledge> editData = knowledgeR.findById(id);
        Date knowledgeCreateDate  = new Date();
        knowledge editData_after = new knowledge();
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
        editData_after.setType(type);
        knowledgeR.save(editData_after);
        return;
    }
}