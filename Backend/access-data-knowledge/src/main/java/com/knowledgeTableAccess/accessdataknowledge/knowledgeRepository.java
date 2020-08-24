package com.knowledgeTableAccess.accessdataknowledge;

import org.springframework.data.repository.CrudRepository;
import java.util.Optional;

import com.knowledgeTableAccess.accessdataknowledge.knowledge;

public interface knowledgeRepository extends CrudRepository<knowledge, Integer> {

    public Optional<knowledge> findById(Integer id);
}