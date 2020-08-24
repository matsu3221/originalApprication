package com.spring_boot.example.sample;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(path = "/demo")
public class TestController {

	@Autowired
	private testRepository testrepo;

	@PostMapping(path = "/add")
	public @ResponseBody String addTest(@RequestParam String name){
        test t = new test();
        t.setName(name);
        testrepo.save(t);
        return "success";
	}

	@GetMapping(path = "/getAll")
	public @ResponseBody Iterable<test> getAllTest(){
        return testrepo.findAll();
	}

}
