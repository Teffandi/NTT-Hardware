
module mult #(`include "parameter.vh")(
input [width-1:0] Operand_1,
input [width-1:0] Operand_2,
output[width-1:0] output_mult
);

wire [2*width-1:0]temp;
assign temp = Operand_1[width-1:0]*Operand_2[width-1:0];
assign output_mult[width-1] = Operand_1[width-1]^Operand_2[width-1];
assign output_mult[width-2:0] = temp[width-2:0];

endmodule