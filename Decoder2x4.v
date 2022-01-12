module Decoder2x4(input [1:0] a, output reg [3:0] y);

always @(*) begin
case(a)
2'b00 : y = 4'b1110;
2'b01 : y = 4'b1101;
2'b10 : y = 4'b1011;
2'b11 : y = 4'b0111;

endcase
end
endmodule
