package com.ajitata6f.calculator;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.util.logging.Level;
import java.util.logging.Logger;

@SpringBootApplication
public class CalculatorApplication {
    private static final String CONSTANT = "constant";

    public static void main(String[] args) {
        Logger.getLogger(CalculatorApplication.class.getName()).log(Level.INFO, CONSTANT);

        SpringApplication.run(CalculatorApplication.class, args);
    }

}
