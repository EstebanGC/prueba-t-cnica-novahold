package com.example.demo.dto;


import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ProductDto {

    private int productId;

    @NotBlank
    private String name;

    @NotNull
    private Boolean available;

    @Min(0)
    private int minUnits;

    @Min(1)
    private int maxUnits;
}
