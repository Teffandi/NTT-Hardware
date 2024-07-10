
module mult #(`include "radix_2_parameter.vh")(
input [width-1:0] Operand_1,
input [width-1:0] Operand_2,
output[width-1:0] mult_output
)

wire [2*width-1:0]temp;
assign temp = Operand_1[width-1:0]*Operand_2[width-1:0];
assign mult_output[15] = Operand_1[width-1]^Operand_2[width-1];
assign mult_output = temp[2*width-9:width-8];

endmodule