
module mult #(parameter WIDTH = 18)(
input [WIDTH-1:0] input_1,
input [WIDTH-1:0] input_2,
output[2*WIDTH-1:0] output_mult
);
wire [2*WIDTH-1:0] in1_temp;
wire [2*WIDTH-1:0] in2_temp;

assign in1_temp = {{18{input_1[17]}},input_1};
assign in2_temp = {{18{input_2[17]}},input_2};
assign output_mult = in1_temp*in2_temp;

endmodule