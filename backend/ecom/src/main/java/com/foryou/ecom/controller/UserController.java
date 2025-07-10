package com.foryou.ecom.controller;

import com.foryou.ecom.model.Users;
import com.foryou.ecom.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
public class UserController {

    @Autowired
    private UserService service;

    @PostMapping("/register")
    public ResponseEntity<Map<String, Users>> register(@RequestBody Users user){
        Users user1=service.register(user);
        if(user1 != null){
            Map<String, Users> response=new HashMap<>();
            response.put("user", user1);
            return new ResponseEntity<>(response, HttpStatus.OK);
        }else{
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PostMapping("/login")
    public ResponseEntity<Map<String, Object>> login(@RequestBody Users user){
        String token=service.verify(user);
        if(token != null){
            Map<String, Object> response = new HashMap<>();
            response.put("token", token);
            response.put("user", user);
            return new ResponseEntity<>(response, HttpStatus.OK);
        }else{
            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        }
    }
}
