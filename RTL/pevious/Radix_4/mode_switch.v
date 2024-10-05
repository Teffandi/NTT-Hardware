
module mode_switch #(`include "parameter.vh")(
input [width-1:0] input_switch,
input [width-1:0] twiddle_factor,
input [width-1:0] butterfly_output,
input select, // 0 for NTT mode, 1 for INTT mode

output [width-1:0] butterfly_input,
output[width-1:0] output_switch

);

wire [width-1:0] temp_output_mult_0;
wire [width-1:0] temp_output_mux_1;

mux_2_1 mux_0(.input_1(temp_output_mult_0),.input_2(input_switch),.select(select),.out(butterfly_input));
mux_2_1 mux_1(.input_1(input_switch),.input_2(butterfly_output),.select(select),.out(temp_output_mux_1));
mux_2_1 mux_2(.input_1(butterfly_output),.input_2(temp_output_mult_0),.select(select),.out(output_switch));
mult mult_0 (.Operand_1(temp_output_mux_1),.Operand_2(twiddle_factor),.output_mult(temp_output_mult_0));

endmodule