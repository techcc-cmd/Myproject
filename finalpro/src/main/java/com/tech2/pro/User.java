package com.tech2.pro;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String profilePhoto;
    private LocalDateTime lastLogin;
    private String skills;  // Example: "Java:80,Spring Boot:70,React:60"
    private int resumeViews;

    public String getSkills() { return skills; }
    public void setSkills(String skills) { this.skills = skills; }

    public int getResumeViews() { return resumeViews; }
    public void setResumeViews(int resumeViews) { this.resumeViews = resumeViews; }


    // getters and setters
    public String getProfilePhoto() { return profilePhoto; }
    public void setProfilePhoto(String profilePhoto) { this.profilePhoto = profilePhoto; }

    public LocalDateTime getLastLogin() { return lastLogin; }
    public void setLastLogin(LocalDateTime lastLogin) { this.lastLogin = lastLogin; }

    @Column(nullable = false, unique = true)
    private String username;

    @Column(nullable = false)
    private String email;

    @Column(nullable = false)
    private String password;

    @Column(name = "resume")
    private String resume;

    @Column(name = "bio", columnDefinition = "TEXT")
    private String bio;

    // --- Constructors ---
    public User() {
    }

    public User(String username, String email, String password) {
        this.username = username;
        this.email = email;
        this.password = password;
    }

    // --- Getters and Setters ---
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getResume() { return resume; }
    public void setResume(String resume) { this.resume = resume; }

    public String getBio() { return bio; }
    public void setBio(String bio) { this.bio = bio; }
}
