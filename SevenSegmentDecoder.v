module SevenSegmentDecoder(input[3:0] in, input showPoint, output reg[7:0] out);

always @(*) begin
  case(in)
    4'd0: out <= 8'b00000011;
    4'd1: out <= 8'b10011111;
    4'd2: out <= 8'b00100101;
    4'd3: out <= 8'b00001101;
    4'd4: out <= 8'b10011001;
    4'd5: out <= 8'b01001001;
    4'd6: out <= 8'b01000001;
    4'd7: out <= 8'b00011111;
    4'd8: out <= 8'b00000001;
    4'd9: out <= 8'b00001001;
    4'd10: out <= 8'b11111101; //dash
    default: out <= 8'b11111111; //blank
  endcase
    if(showPoint == 0)
      out[0] <= 1;
end
endmodule
