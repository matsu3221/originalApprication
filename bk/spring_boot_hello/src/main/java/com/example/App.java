package tools.springsample.springsample02;

import tools.springsample.springsample02.service.SampleService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@EnableAutoConfiguration
@ComponentScan

public class App {

    @Autowired
    private SampleService sampleService;

    @RequestMapping("/")
    @ResponseBody
    public String hello(){
        System.out.println("hello!!");
        return sampleService.getMessage();
    }

    public static void main(String[] args){
        SpringApplication.run(App.class, args);
    }
}