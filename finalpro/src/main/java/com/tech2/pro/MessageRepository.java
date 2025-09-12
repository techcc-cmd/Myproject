package com.tech2.pro;

import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface MessageRepository extends JpaRepository<Message, Long> {

    // Add this method to fetch messages for a user
    List<Message> findByUser(User user);
}
