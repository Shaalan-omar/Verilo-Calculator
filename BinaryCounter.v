
module BinaryCounter #(parameter n = 3) (input clk, reset,
 output reg [n-1:0] count);
always @(posedge clk, posedge reset) begin
if (reset == 1)begin
    count <= 0;
end
    else
    count <= count + 1;
end

endmodule
