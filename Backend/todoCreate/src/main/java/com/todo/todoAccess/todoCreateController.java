package com.todo.todoAccess;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.Optional;

import com.todo.todoAccess.todoRepository;

@Controller
@RequestMapping(path="/todoAccess")
public class todoCreateController {
    @Autowired
    private todoRepository tR;

    @PostMapping("/add")
    public @ResponseBody String addNewTodo(@RequestParam String todoName,
    @RequestParam String description,@RequestParam String todoDate, @RequestParam String yoken){
        todo t = new todo();
        Date todoDateFC  = new Date();
        t.setTodoName(todoName);
        t.setDescription(description);
        SimpleDateFormat todoDateFormat = new SimpleDateFormat("yyyy/mm/dd hh:mm:ss");
        try{
            todoDateFC = todoDateFormat.parse(todoDate);
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        t.setTodoDate(todoDateFC);
        t.setYoken(yoken);
        tR.save(t);
        return "todo Add Success!!!";
    }

    @GetMapping("/all")
    public @ResponseBody Iterable<todo> getAllTodo(){
        return tR.findAll();
    }

    @PostMapping("/edit")
    public @ResponseBody String editTodo(@RequestParam Integer Id,@RequestParam String todoName,@RequestParam String description,
    @RequestParam String todoDate,@RequestParam String yoken){
        Optional<todo> editData = tR.findById(Id);
        Date todoDateFC  = new Date();
        todo editData_af = new todo();
        editData_af = editData.get();
        System.out.println(editData_af.getTodoName());
        editData_af.setTodoName(todoName);
        editData_af.setDescription(description);
        SimpleDateFormat todoDateFormat = new SimpleDateFormat("yyyy/mm/dd hh:mm:ss");
        try{
            todoDateFC = todoDateFormat.parse(todoDate);
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        editData_af.setTodoDate(todoDateFC);
        editData_af.setYoken(yoken);
        tR.save(editData_af);
        return "Success";
    }
}