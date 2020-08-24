package com.knowledgeTableAccess.demo;

import org.springframework.data.repository.CrudRepository;
import java.util.Optional;

import com.knowledgeTableAccess.demo.*;

public interface knowledgeRepository extends CrudRepository<knowledgeEntity, Integer> {

    public Optional<knowledgeEntity> findById(Integer id);
}