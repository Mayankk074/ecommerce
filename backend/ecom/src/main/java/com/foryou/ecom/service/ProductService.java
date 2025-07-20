package com.foryou.ecom.service;

import com.foryou.ecom.model.Cart;
import com.foryou.ecom.model.Product;
import com.foryou.ecom.repo.CartRepo;
import com.foryou.ecom.repo.ProductRepo;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@Service
public class ProductService {

    private ProductRepo repo;
    private CartRepo cartRepo;

    public ProductService(ProductRepo repo, CartRepo cartRepo){
        this.repo=repo;
        this.cartRepo=cartRepo;
    }

    public List<Product> getAllProducts(){
        return repo.findAll();
    }

    public Product getProductById(int id) {
        return repo.findById(id).orElse(null);
    }

    public Product addProduct(Product product, MultipartFile imageFile) throws IOException {
        product.setImageName(imageFile.getOriginalFilename());
        product.setImageType(imageFile.getContentType());
        product.setImageFile(imageFile.getBytes());

        return repo.save(product);
    }

    public Product updateProduct(int id, Product product, MultipartFile imageFile) throws IOException {
        product.setImageFile(imageFile.getBytes());
        product.setImageName(imageFile.getOriginalFilename());
        product.setImageType(imageFile.getContentType());
        return repo.save(product);
    }

    public void deleteById(int id) {
        repo.deleteById(id);
    }

    public List<Product> search(String keyword) {
        return repo.search(keyword);
    }

    public String addToCart(Cart item) {
        cartRepo.save(item);
        return "Saved";
    }

    public List<Cart> getCart() {
        return cartRepo.findAll();
    }
}
