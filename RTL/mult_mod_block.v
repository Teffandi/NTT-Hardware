
module mult_mod_block #(parameter WIDTH = 18)(
input [WIDTH-1:0] input_1,
input [WIDTH-1:0] input_2,
input [WIDTH-1:0] weight_1,
input [WIDTH-1:0] weight_2,
output [WIDTH-1:0] output_1,
output [WIDTH-1:0] output_2

);

wire [2*WIDTH-1:0] mult_0_output;
wire [2*WIDTH-1:0] mult_1_output;


mult #(.WIDTH(WIDTH)) mult_0 (.input_1(input_1),.input_2(weight_1),.output_mult(mult_0_output));
mult #(.WIDTH(WIDTH)) mult_1 (.input_1(input_2),.input_2(weight_2),.output_mult(mult_1_output));
modulo #(.WIDTH(WIDTH)) mod_0 (.input_mod(mult_0_output),.output_mod(output_1));
modulo #(.WIDTH(WIDTH)) mod_1 (.input_mod(mult_1_output),.output_mod(output_2));


endmodule