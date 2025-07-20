package com.foryou.ecom.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Entity
@AllArgsConstructor
@NoArgsConstructor
public class Cart {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    //Creating a foreign key to the product table
    // It will refer to id column of product table.
    // This field is a relationship to another entity — the Product class.
    @ManyToOne(fetch = FetchType.EAGER)
    //In my current table cart, use a column called product_id to store the foreign key
    //It will fetch product from product table with id.
    @JoinColumn(name = "product_id")
    private Product product;

    private int quantity;

    private String username;

    @Override
    public String toString() {
        return username+" "+quantity;
    }
}
