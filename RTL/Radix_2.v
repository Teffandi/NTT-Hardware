
module Radix_2 #(parameter WIDTH = 18)(
input [WIDTH-1:0] input_1,
input [WIDTH-1:0] input_2,
input [WIDTH-1:0] weight_1,
input [WIDTH-1:0] weight_2,
output[WIDTH-1:0] output_1,
output[WIDTH-1:0] output_2

);

wire [WIDTH-1:0] mult_mod_block_output_0;
wire [WIDTH-1:0] mult_mod_block_output_1;


mult_mod_block #(.WIDTH(WIDTH)) mult_mod_block_0 (.input_1(input_1),.weight_1(weight_1),.input_2(input_2),.weight_2(weight_2),.output_1(mult_mod_block_output_0),.output_2(mult_mod_block_output_1));
butterfly_block #(.WIDTH(WIDTH)) butterfly_block_0 (.input_1(mult_mod_block_output_0),.input_2(mult_mod_block_output_1),.output_1(output_1),.output_2(output_2));


endmodule


