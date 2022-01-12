module SevenSegementShower(input[3:0] digit1, 
input [3:0]digit2, 
input [3:0]digit3, 
input [3:0]digit4, 
input clk, 
input reset,
input showPoint,
output [7:0]ss, 
output [3:0]enables);
wire [7:0] ss1, ss2, ss3, ss4;
wire [1:0] select;
wire clk_out;
ClkDivider #(500000)c(clk, reset, clk_out); // clk_out in 100Hz
BinaryCounter #(2)ctr(clk_out, reset, select); // binary counter 

SevenSegmentDecoder d1(digit1, 0, ss1);
SevenSegmentDecoder d2(digit2, 0, ss2);
SevenSegmentDecoder d3(digit3, showPoint, ss3);
SevenSegmentDecoder d4(digit4, 0, ss4);

Mux4x1 multiplexer (select, ss1, ss2, ss3, ss4, ss);
Decoder2x4 dec(select, enables);

endmodule
