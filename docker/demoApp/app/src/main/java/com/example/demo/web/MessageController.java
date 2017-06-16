package com.example.demo.web;

import com.example.demo.entity.Message;
import com.example.demo.repository.MessageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Collections;

/**
 * Created by zheng on 2017/6/16.
 * For demo.
 */
@Controller
public class MessageController {

  private final MessageRepository messageRepository;

  @Autowired
  public MessageController(MessageRepository messageRepository) {
    this.messageRepository = messageRepository;
  }


  @GetMapping(value = "/")
  public String search(@RequestParam(required = false) String pattern, Model model) {
    if (pattern == null) {
      model.addAttribute("messages", Collections.emptyList());
    } else {
      model.addAttribute("messages", messageRepository.findByContentContains(pattern));
    }
    return "index";
  }

  @GetMapping(value = "/insert")
  public String insertPage(Model model) {
    model.addAttribute("message", new Message(""));
    return "insert";
  }

  @PostMapping(value = "/insert")
  public String insert(Message message, Model model) {
    if ("".equals(message.getContent())) {
      model.addAttribute("status", "Content cannot be empty!");
      return "insert";
    }
    messageRepository.save(message);
    model.addAttribute("status", "Insert success!");
    return "insert";
  }
}
