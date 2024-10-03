package com.example.demo.dto;

import com.example.demo.entity.Product;
import org.springframework.stereotype.Component;

@Component
public class Mapper {

    public Product fromProductDtoToEntity(ProductDto productDto) {
        Product product = new Product();
        product.setProductId(productDto.getProductId());
        product.setName(productDto.getName());
        product.setAvailable(productDto.getAvailable());
        product.setMinUnits(productDto.getMinUnits());
        product.setMaxUnits(productDto.getMaxUnits());
        return product;
    }

    public ProductDto fromEntityToProductDto(Product product) {
        ProductDto productDto = new ProductDto();
        productDto.setProductId(product.getProductId());
        productDto.setName(product.getName());
        productDto.setAvailable(product.getAvailable());
        productDto.setMinUnits(product.getMinUnits());
        productDto.setMaxUnits(product.getMaxUnits());
        return productDto;
    }
}
