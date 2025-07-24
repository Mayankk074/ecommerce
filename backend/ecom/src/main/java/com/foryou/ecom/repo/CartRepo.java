package com.foryou.ecom.repo;

import com.foryou.ecom.model.Cart;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface CartRepo extends JpaRepository<Cart, Integer> {

    //Deleting all cartItems with username
    @Transactional
    @Modifying
    @Query("DELETE FROM Cart c WHERE c.username = :username")
    void deleteByUsernameCustom(String username);

    //Selecting all cartItems with username
    @Query("SELECT c FROM Cart c WHERE c.username = :username")
    List<Cart> findByUsername(String username);
}
