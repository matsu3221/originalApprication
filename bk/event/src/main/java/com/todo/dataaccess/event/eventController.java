package com.todo.dataaccess.event;

import java.sql.Date;

import com.todo.dataaccess.event.eventRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(path="/event")
public class eventController {
    @Autowired
    private eventRepository eventRepo;

    @PostMapping(path="/add")
    // public String addEvent(@RequestParam String name,
    public @ResponseBody String addEvent(@RequestParam String name,@RequestParam String eventDate,
    @RequestParam String space){
        event eve = new event();
        eve.setName(name);
        eve.setEventDate(eventDate);
        eve.setSpace(space);
        eventRepo.save(eve);
        return "Success";
    }

    @GetMapping(path="/all")
    public @ResponseBody Iterable<event> getAllEvent(){
        return eventRepo.findAll();
    }
}