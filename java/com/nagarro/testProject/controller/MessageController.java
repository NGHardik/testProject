package com.nagarro.testProject.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class MessageController {
    
    @GetMapping("/message")
    public String getMessage() {
        return "Hello, world!";
    }
}