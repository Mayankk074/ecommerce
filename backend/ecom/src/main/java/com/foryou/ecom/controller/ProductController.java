package com.foryou.ecom.controller;

import com.foryou.ecom.model.Cart;
import com.foryou.ecom.model.Product;
import com.foryou.ecom.service.ProductService;
import org.springframework.boot.autoconfigure.graphql.GraphQlProperties;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@RestController
@CrossOrigin
@RequestMapping("/api")
public class ProductController {

    private ProductService service;

    public ProductController(ProductService service){
        this.service=service;
    }

    @GetMapping("/products")
    public ResponseEntity<List<Product>> getAllProducts(){
        return new ResponseEntity<>(service.getAllProducts(), HttpStatus.OK);
    }

    @RequestMapping("/product/{id}")
    public ResponseEntity<Product> getProduct(@PathVariable int id){
        Product product=service.getProductById(id);
        if(product != null){
            return new ResponseEntity<>(product, HttpStatus.OK);
        }
        else{
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @PostMapping("/product")
    public ResponseEntity<?> addProduct(@RequestPart Product product,
                                        @RequestPart MultipartFile imageFile){

        try{
            Product product1=service.addProduct(product, imageFile);

            return new ResponseEntity<>(product1, HttpStatus.CREATED);
        }
        catch(Exception e){
            return new ResponseEntity<>(e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("/product/{productId}/image")
    public ResponseEntity<byte[]> getImageByProductId(@PathVariable int productId){
            Product product=service.getProductById(productId);
            byte[] imageFile=product.getImageFile();

            return ResponseEntity.ok()
                    .contentType(MediaType.valueOf(product.getImageType()))
                    .body(imageFile);

    }

    @PutMapping("/product/{id}")
    public ResponseEntity<String> updateProduct(@PathVariable int id,
                                                @RequestPart Product product,
                                                @RequestPart MultipartFile imageFile){
        Product product1=null;
        try {
            product1 = service.updateProduct(id, product, imageFile);
        } catch (IOException e) {
            return new ResponseEntity<>("Server error", HttpStatus.BAD_REQUEST);
        }
        if(product1 != null){
            return new ResponseEntity<>("Updated successfully", HttpStatus.OK);
        }
        else{
            return new ResponseEntity<>("server error", HttpStatus.BAD_REQUEST);
        }
    }

    @DeleteMapping("/product/{id}")
    public ResponseEntity<String> deleteById(@PathVariable int id){
        Product product=service.getProductById(id);
        if(product != null){
            service.deleteById(id);
            return new ResponseEntity<>("Deleted successfully", HttpStatus.OK);
        }
        else{
            return new ResponseEntity<>("Not Found", HttpStatus.NOT_FOUND);
        }
    }

    // This will disable auto-commit and allow reading @Lob fields like imageFile.
    // because when reading @lob it gives error.
    @Transactional(readOnly = true)
    @GetMapping("/products/search")
    public ResponseEntity<List<Product>> search(@RequestParam String keyword){
        System.out.println(keyword);
        List<Product> products=service.search(keyword);
        return new ResponseEntity<>(products, HttpStatus.OK);
    }

    @PostMapping("/addtocart")
    public ResponseEntity<String> addToCart(@RequestBody Cart item){
        System.out.println(item.toString());
        service.addToCart(item);

        return new ResponseEntity<>("Saved", HttpStatus.OK);
    }

    //Sending all cart items
    @Transactional(readOnly = true)
    @GetMapping("/cart/{username}")
    public ResponseEntity<List<Cart>> getCart(@PathVariable String username){
        System.out.println("In cart");
        return new ResponseEntity<>(service.getCart(username), HttpStatus.OK);
    }

    @DeleteMapping("/cart/{username}")
    public ResponseEntity<String> deleteCartItemsWithUsername(@PathVariable String username){
        service.deleteAllByUsername(username);

        return  new ResponseEntity<>("Deleted", HttpStatus.OK);
    }

}
