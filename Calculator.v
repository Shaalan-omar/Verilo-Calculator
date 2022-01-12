module Calculator(input clk, input [8:0] buttons, input resetButton, output [7:0]ss,[3:0] enables);
  reg[3:0] binary1; // right most digit
  reg[3:0] binary2; // second right most digit
  reg[3:0] binary3; // second left most digit
  reg[3:0] binary4; // left most digit
  
  //Result digits
  reg[3:0] digit1;
  reg[3:0] digit2;
  reg[3:0] digit3;
  reg[3:0] digit4;
  
  //Results across each number
  wire[7:0] sum, sub, div;
  wire[13:0] mult;

  //Resulting numbers
  wire[7:0] number1;
  wire[7:0] number2;
  
  //flags to know what to show 
  reg showPoint;
  reg showNumbers;

  assign number1 = binary1 + binary2 * 10;
  assign number2 = binary3 + binary4 * 10;

    assign sum = number1 + number2;
    assign sub = number1 - number2;
    assign div = (number2 == 0) ? 0 : number1 / number2;
    assign mult = number1 * number2;

  //Handle the seven segment kolha
  SevenSegementShower sevenSegShwr(.digit1(digit1), .digit2(digit2), 
  .digit3(digit3), .digit4(digit4), .clk(clk), .reset(resetButton),
  .showPoint(showPoint) ,.ss(ss), .enables(enables));
    reg[13:0] result;
    
    // incrementing the numbers 
    always @(resetButton, buttons[0], buttons[1], buttons[2], buttons[3]) begin
        if(resetButton == 1) begin
            binary1 = 4'b0;
            binary2 = 4'b0;
            binary3 = 4'b0;
            binary4 = 4'b0;
        end
        else begin
            binary1 = binary1 + buttons[0];
            if(binary1 == 9)
                binary1 = 0;

            binary2 = binary2 + buttons[1];
            if(binary2 == 9)
                binary2 = 0;
            
            binary3 = binary3 + buttons[2];
            if(binary3 == 9)
                binary3 = 0;
            
            binary4 = binary4 + buttons[3];
            if(binary4 == 9)
                binary4 = 0;
        end
    end

    //Choosing which operation to happen
    always @(resetButton, buttons[4], buttons[5], buttons[6], buttons[7], buttons[8], showNumbers) begin
       showNumbers = 0;
       showPoint = 0;
       result = sum;
       if(resetButton)
            showPoint = 1;
       if(buttons[8])begin
            showNumbers = 1;
            showPoint = 1;
       end
       if(buttons[4])
            result = sum;
       else if(buttons[5])
            result = sub;
       else if(buttons[6])
            result = mult;
       else if (buttons[7])
            result = div;
    end

    //Setting the resulting digits to show it in the seven segement display
    always @(result)begin        
        digit4 = result % 4'd10;
        result = result /10;
        digit3 = result % 4'd10;
        result = result /10;
        digit2 = result % 4'd10;
        result = result /10;
        if(result < 0) begin
            digit1 = 10;
        end
        else
            digit1 = result % 4'd10;
    end

endmodule