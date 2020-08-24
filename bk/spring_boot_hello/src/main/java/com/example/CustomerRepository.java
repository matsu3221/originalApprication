package tools.springsample.springsample02.repository;

import org.springframework.stereotype.Repository;

@Repository
public class CustomerRepository{
    public String getCustomer(){
        System.out.println("Repository called");
        return "Smith";
    }
}