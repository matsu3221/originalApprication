package com.todo.todoAccess;

import org.springframework.data.repository.CrudRepository;
import java.util.Optional;

import com.todo.todoAccess.todo;

// This will be AUTO IMPLEMENTED by Spring into a Bean called userRepository
// CRUD refers Create, Read, Update, Delete

public interface todoRepository extends CrudRepository<todo, Integer> {

    public Optional<todo> findById(Integer Id);
}