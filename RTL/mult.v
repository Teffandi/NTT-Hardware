
module mult #(parameter WIDTH = 18)(
input [WIDTH-1:0] input_1,
input [WIDTH-1:0] input_2,
output[2*WIDTH-1:0] output_mult
);

assign output_mult = input_1*input_2;

endmodule