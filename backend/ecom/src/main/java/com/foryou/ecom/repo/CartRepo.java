package com.foryou.ecom.repo;

import com.foryou.ecom.model.Cart;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CartRepo extends JpaRepository<Cart, Integer> {
}
