package com.example.demo.entity;

import javax.persistence.*;
import java.util.Objects;

/**
 * Created by zheng on 2017/6/16.
 * For demo.
 */
@Entity
public class Message {
  @Id
  @GeneratedValue(strategy = GenerationType.AUTO)
  private Long id;

  @Column(nullable = false, length = 1023)
  private String content;

  public Message() {
  }

  public Message(String content) {
    this.content = content;
  }

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  public String getContent() {
    return content;
  }

  public void setContent(String content) {
    this.content = content;
  }

  @Override
  public boolean equals(Object o) {
    if (this == o) return true;
    if (o == null || getClass() != o.getClass()) return false;
    Message message = (Message) o;
    return Objects.equals(getId(), message.getId());
  }

  @Override
  public int hashCode() {
    return Objects.hash(getId());
  }

  @Override
  public String toString() {
    return "Message{" + "id=" + getId() +
               ", content='" + getContent() + '\'' +
               '}';
  }
}
