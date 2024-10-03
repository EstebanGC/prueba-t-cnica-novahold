package com.example.demo.service.impl;

import com.example.demo.dto.Mapper;
import com.example.demo.dto.ProductDto;
import com.example.demo.entity.Product;
import com.example.demo.repository.ProductRepository;
import com.example.demo.service.ProductService;
import com.example.demo.util.BadArgumentsException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private Mapper mapper;

    @Override
    public List<ProductDto> findAllProducts() {
        List<ProductDto> productDto = new ArrayList<>();
        productRepository.findAll().forEach(product -> productDto.add(mapper.fromEntityToProductDto(product)));
        return productDto;
    }

    @Override
    public ProductDto createProduct(ProductDto productDto) throws BadArgumentsException {
        Product product = mapper.fromProductDtoToEntity(productDto);

        Product savedProduct = productRepository.save(product);

        return mapper.fromEntityToProductDto(savedProduct);
    }

    @Override
    public ProductDto updateProduct(ProductDto productDto) {
        return mapper.fromEntityToProductDto(productRepository.save(mapper.fromProductDtoToEntity(productDto)));
    }

    @Override
    public void deleteProduct(int productId) {
        productRepository.deleteById(productId);
    }
}
