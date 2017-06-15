package com.example.demo.repository;

import com.example.demo.entity.Message;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * Created by zheng on 2017/6/16.
 * For demo.
 */
public interface MessageRepository extends JpaRepository<Message, Long> {
  List<Message> findByContentContains(String content);
}
