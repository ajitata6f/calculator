package com.ajitata6f.calculator;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.assertEquals;

@ExtendWith(MockitoExtension.class)
class CalculatorApplicationTests {

    @InjectMocks
    private CalculatorService calculatorService;

    @Test
    public void testSum() {
        assertEquals(5, calculatorService.sum(2, 3));
    }

}
