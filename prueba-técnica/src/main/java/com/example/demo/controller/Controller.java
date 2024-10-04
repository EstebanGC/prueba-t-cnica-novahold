package com.example.demo.controller;

import com.example.demo.dto.ProductDto;
import com.example.demo.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/")
@CrossOrigin("*")
public class Controller {

    @Autowired
    private ProductService productService;

    @GetMapping("/get/all/products")
    public List<ProductDto> getAllProducts() {
        return productService.findAllProducts();
    }

    @PostMapping("save/product")
    public ProductDto createProduct(@RequestBody ProductDto productDto) throws Exception {
        return productService.createProduct(productDto);
    }

    @PutMapping("update/product")
    public ProductDto updateProduct(@RequestBody ProductDto productDto) {
        return productService.updateProduct(productDto);
    }

    @DeleteMapping("delete/product/{productId}")
    public void deleteProduct(@PathVariable int productId){
        productService.deleteProduct(productId);
    }
}

