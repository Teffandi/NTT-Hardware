//Radix 2 consisted of upper and lower part
module Radix_2 #(parameter WIDTH = 18)(
input [WIDTH-1:0] input_1,
input [WIDTH-1:0] input_2,
input [WIDTH-1:0] weight_1,
input [WIDTH-1:0] weight_2,
input mode, // 0 for NTT, 1 for INTT
output [WIDTH-1:0] output_1,
output [WIDTH-1:0] output_2

);


wire [WIDTH-1:0] mux_to_mult_1;
wire [WIDTH-1:0] butter_to_mux_1;
wire [2*WIDTH-1:0] mult_to_mod_1;
wire [WIDTH-1:0] mod_to_mux_1;
wire [WIDTH-1:0] mux_to_butter_1;

wire [WIDTH-1:0] mux_to_mult_2;
wire [WIDTH-1:0] butter_to_mux_2;
wire [2*WIDTH-1:0] mult_to_mod_2;
wire [WIDTH-1:0] mod_to_mux_2;
wire [WIDTH-1:0] mux_to_butter_2;

// Multiplication
mult #(.WIDTH(WIDTH)) mult_0 (.input_1(mux_to_mult_1), .input_2(weight_1), .output_mult(mult_to_mod_1));
mult #(.WIDTH(WIDTH)) mult_1 (.input_1(mux_to_mult_2), .input_2(weight_2), .output_mult(mult_to_mod_2));
// assign mult_to_mod_1 = mux_to_mult_1*weight_1;
// assign mult_to_mod_2 = mux_to_mult_2*weight_2;

// Adder
adder #(.WIDTH(WIDTH)) add_0 (.input_1(mux_to_butter_1), .input_2(mux_to_butter_2), .output_add(butter_to_mux_1));
sub #(.WIDTH(WIDTH)) sub_0 (.input_1(mux_to_butter_1), .input_2(mux_to_butter_2), .output_add(butter_to_mux_2));
// assign butter_to_mux_1 = mux_to_butter_1 + mux_to_butter_2;
// assign butter_to_mux_2 = mux_to_butter_1 - mux_to_butter_2;

mux_2_1 #(.WIDTH(WIDTH)) mux_0 (.input_1(input_1),.input_2(butter_to_mux_1),.select(mode),.out(mux_to_mult_1));
mux_2_1 #(.WIDTH(WIDTH)) mux_1 (.input_1(mod_to_mux_1),.input_2(input_1),.select(mode),.out(mux_to_butter_1));
mux_2_1 #(.WIDTH(WIDTH)) mux_2 (.input_1(butter_to_mux_1),.input_2(mod_to_mux_1),.select(mode),.out(output_1));

mux_2_1 #(.WIDTH(WIDTH)) mux_3 (.input_1(input_2),.input_2(butter_to_mux_2),.select(mode),.out(mux_to_mult_2));
mux_2_1 #(.WIDTH(WIDTH)) mux_4 (.input_1(mod_to_mux_2),.input_2(input_2),.select(mode),.out(mux_to_butter_2));
mux_2_1 #(.WIDTH(WIDTH)) mux_5 (.input_1(butter_to_mux_2),.input_2(mod_to_mux_2),.select(mode),.out(output_2));


modulo #(.WIDTH(WIDTH)) mod_0 (.input_mod(mult_to_mod_1),.output_mod(mod_to_mux_1));
modulo #(.WIDTH(WIDTH)) mod_1 (.input_mod(mult_to_mod_2),.output_mod(mod_to_mux_2));


endmodule