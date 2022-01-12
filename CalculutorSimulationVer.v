module CalculatorSimulationVer(input clk, input [8:0] buttons, input resetButton, output [7:0]ss,[3:0] enables,
 output reg [13:0] result,
 output reg[7:0] number1,
 output reg[7:0] number2
 );
  reg[3:0] binary1; // right most digit
  reg[3:0] binary2; // second right most digit
  reg[3:0] binary3; // second left most digit
  reg[3:0] binary4; // left most digit
  reg[3:0] final1;
  reg[3:0] final2;
  reg[3:0] final3;
  reg[3:0] final4;
  reg[7:0] sum, sub, div;
  reg[13:0] mult;
  reg showPoint;
 
  //Handle the seven segment kolha
  SevenSegementShower sevenSegShwr(.digit1(final1), .digit2(final2), .digit3(final3), .digit4(final4), .clk(clk), .reset(resetButton),.showPoint(showPoint) ,.ss(ss), .enables(enables));

   //Handling the input of the 4 digits
   always @(resetButton, buttons[0], buttons[1], buttons[2], buttons[3]) begin
        if(resetButton == 1) begin
            binary1 <= 4'b0;
            binary2 <= 4'b0;
            binary3 <= 4'b0;
            binary4 <= 4'b0;
        end        
        else if(buttons[0] == 1 && ~resetButton) begin
              binary1 <= binary1 + 1;
            if(binary1 == 9)
              binary1 <= 0;
        end
        else if(buttons[1] == 1&& ~resetButton) begin
            binary2 <= binary2 + 1;
            if(binary2 == 9)
                binary2 <= 0;
        end
        else if(buttons[2] == 1&& ~resetButton) begin
            binary3 <= binary3 + 1;
            if(binary3 == 9)
                binary3 <= 0;
        end
        else if(buttons[3] == 1 && ~resetButton) begin
            binary4 <= binary4 + 1;
            if(binary4 == 9)
                binary4 <= 0;
        end
        else begin
            binary1 <= binary1;
            binary2 <= binary2;
            binary3 <= binary3;
            binary4 <= binary4;
        end
        number1 = binary1 + (binary2 * 4'd10); 
        number2 = binary3 + (binary4 * 4'd10);
        result <= number1 + number2 * 100; // a simple and easy way to Update the full number
   end

  // Logic
  always @(posedge(resetButton), posedge(buttons[4]), posedge(buttons[5]), posedge(buttons[6]), posedge(buttons[7]), posedge(buttons[8])) begin
    if(resetButton == 1) begin
        final1 <= 0;
        final2 <= 0;
        final3 <= 0;
        final4 <= 0;
        result <= 0;
        mult <= 0;
        sub <= 0;
        sum <= 0;
        div <= 0;
        showPoint <= 1;
    end
    
    else if(buttons[4] ) begin // addition 
        result <= number1 + number2;
        sum <= result;
        final4 <= sum % 4'd10;
        sum <= sum / 10;
        final3 <= sum % 4'd10;
        sum <= sum / 10;
        final2 <= sum % 4'd10;
        final1 <= 11;      
        showPoint <= 0;  
    end
    else if(buttons[5]) begin // subtraction
        if(number2 > number1) begin
            result <= number2 - number1;
            sub <= result;
            final1 <=10;
        end
        else begin 
            result <= number1 - number2;
            sub <= result;
            final1 <= 11;
        end
        final4 <= sub % 4'd10;
        sub <= sub /10;
        final3 <= sub % 4'd10;
        sub <= sub /10;
        final2 <= sub % 4'd10;
        showPoint <= 0;
    end
    else if (buttons[6]) begin // multiplication
        result <= number1 * number2;
        mult <= result;
        final4 <= mult % 4'd10;
        mult <= mult /10;
        final3 <= mult % 4'd10;
        mult <= mult /10;
        final2 <= mult % 4'd10;
        mult <= mult /10;
        final1 <= mult % 4'd10;
        showPoint <= 0;
    end
    else if (buttons[7] == 1) begin // Division
        if(number1 == 0) begin
            result <= 0;
            div <= 0;
            final1 <= 12;
            final2 <= 12;
            final3 <= 12;
            final4 <= 12;
            showPoint <= 0;
        end
        else begin
            result <= number2 / number1;
            div <= result;
            final4 <= div % 4'd10;
            div <= div /10;
            final3 <= div % 4'd10;
            div <= div /10;
            final2 <= div % 4'd10;
            final1 <= 11;
            showPoint <= 0;
        end // else end
    end // else if end
    else if (buttons[8] == 1) begin // show the full number
        result <= number1 + number2 * 100; // full number
        final1 <= binary1;
        final2 <= binary2;
        final3 <= binary3;
        final4 <= binary4;
        showPoint <= 1;
    end // else if end
  end // always end
endmodule
