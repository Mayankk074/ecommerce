package com.foryou.ecom.repo;

import com.foryou.ecom.model.Users;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepo extends JpaRepository<Users, Integer> {

    Users findUserByUsername(String username);
}
