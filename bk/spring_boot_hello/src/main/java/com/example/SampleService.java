package tools.springsample.springsample02.service;

import tools.springsample.springsample02.repository.CustomerRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SampleService {
    @Autowired
    private CustomerRepository customerRepository;

    public String getMessage(){
        System.out.println("Servce called");
        return "Hello world. Hello" + customerRepository.getCustomer() + ".";
    }
}