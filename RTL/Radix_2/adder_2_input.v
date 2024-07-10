`include "mux_2_1.v"

module adder_2 #(`include "radix_2_parameter.vh")(
input [width-1:0] Operand_1,
input [width-1:0] Operand_2,
input mode, // 0 to add, 1 to subtract
output reg [width-1:0] adder_output
);

wire mux_0_to_add [width-1:0];
mux_2_1 mux_0 (.input_1(Operand_2),.input_2(~(Operand_2)),.select(mode),.out(mux_0_to_add));
adder_output = Operand_1 + mux_0_to_add + mode;

endmodule