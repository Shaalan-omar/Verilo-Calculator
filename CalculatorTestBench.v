module CalculatorTestBench();
    reg clk;
    reg[8:0] buttons;
    reg resetButton;
    wire[7:0] ss;
    wire[3:0] enables;
    wire[13:0] result;
    wire[7:0] number1;
    wire[7:0] number2;
    CalculatorSimulationVer c(.clk(clk), .buttons(buttons), .resetButton(resetButton), .ss(ss), .enables(enables), .result(result),.number1(number1), .number2(number2));
    integer i;
    initial begin
        clk = 0;
        //Initial State that must be inialized
        resetButton = 1;
        buttons = 0;
        #10
        resetButton = 0; // removing the reset Button
        #10
        for(i = 0; i < 9; i = i + 1) begin: incrementingD1
            #1
            buttons[0] = 1;
            #1
            buttons[0] = 0;
        end
        buttons[0] = 0;
        for(i = 0; i < 9; i = i + 1) begin: incrementingD2
            #1
            buttons[1] = 1;
            #1
            buttons[1] = 0;
        end
        buttons[1] = 0;
        for(i = 0; i < 9; i = i + 1) begin: incrementingD3
            #1
            buttons[2] = 1;
            #1
            buttons[2] = 0;
        end
        buttons[2] = 0;
        for(i = 0; i < 9; i = i + 1) begin: incrementingD4
            #1
            buttons[3] = 1;
            #1
            buttons[3] = 0;
        end
        buttons[3] = 0;
       #5
       //test 1: Adding the results (expected 198) Time: 97ns to 120ns
       buttons[4] = 1;
       #20
       buttons[4] = 0;
       #5
       buttons[6] = 1; // Test 2: multiplication (expected 9801) Time: 120ns to 147ns
       #20
       buttons[6] = 0;
       #5
       buttons[5] = 1; // Test 3: Subtraction (expected 0) Time: 147ns to 171ns
       #20
       buttons[5] = 0;
       #5
       buttons[7] = 1; // Test 4: division (expected 1) Time: 171ns to 195ns
       #20
       buttons[7] = 0;
       #5
       buttons[8] = 1; // Test 5: showing both numbers (expected 9999) Time: 195ns to 220ns
       #20 
       buttons[8] = 0;
       #5
       //Putting the first number to be 98
       for(i = 0; i < 9; i = i + 1) begin: settingD1To8
           #1
           buttons[0] = 1;
           #1
           buttons[0] = 0;
       end
       buttons[0] = 0;
       #5
       buttons[8] = 1; // Test 6: Showing both numbers after change (9998) Time: 240ns to 270ns
       #20
       buttons[8] = 0;
       #5
       buttons[5] = 1; // Test 7: Subtraction (expected 1) Time: 270ns to 320ns
       #20
       buttons[5] = 0;
       #5
       buttons[7] = 1; // Test 8: division (expected 1) Time: 270ns to 320ns
       #20
       buttons[7] = 0;
       #5
       buttons[8] = 1; // Test 9: Showing both numbers after change (9998) Time: 320ns to 342ns
       #20
       buttons[8] = 0;
       for(i = 0; i < 4; i = i + 1) begin: puttingD4To3
        #1
        buttons[3] = 1;
        #1
        buttons[3] = 0;      
       end
       buttons[3] = 0;
       for(i = 0; i < 3; i = i + 1) begin: puttingD3To2
        #1
        buttons[2] = 1;
        #1
        buttons[2] = 0;      
       end
       buttons[2] = 0;
       #5
       buttons[8] = 1; // Test 10: Showing both numbers after change (3298) Time: 354ns to 384ns
       #20
       buttons[8] = 0;
       #5
       buttons[5] = 1; // Test 11: subtraction (expected 66 "The negative sign shows in the FPGA") Time: 384ns to 408ns
       #20
       buttons[5] = 0;
       #5
       buttons[7] = 1; // Test 12: division (expected 0) Time: 409ns to 434ns
       #20
       buttons[7] = 0;       
       #5
       buttons[6] = 1; // Test 13: Multiplication (expected 3136) Time: 434ns to 459ns
       #20
       buttons[6] = 0;     
       #5
       buttons[8] = 1; // Test 14: Showing the original number (expected 3298) Time: 459ns to 481ns
       #20
       buttons[8] = 0;
       for(i = 0; i < 2; i = i + 1) begin: puttingD1To0
        #1
        buttons[0] = 1;
        #1
        buttons[0] = 0;
       end
       buttons[0] = 0;
       for(i = 0; i < 2; i = i + 1) begin: puttingD2To1
        #1
        buttons[1] = 1;
        #1
        buttons[1] = 0;
       end
       buttons[1] = 0;
       #5
       buttons[8] = 1; // Test 15: Showing the number (expected 3210) Time: 487ns to 515ns
       #20
       buttons[8] = 0;       
       #5
       buttons[7] = 1; // Test 16: Division (expected 3) Time: 515ns+
       #20
       buttons[7] = 0;
       
       
    end
    always
        #1 clk = ~clk;
    
endmodule
