
module adder #(parameter WIDTH = 18)(
input [WIDTH-1:0] input_1,
input [WIDTH-1:0] input_2,
output[WIDTH-1:0] output_add
);
wire [2*WIDTH-1:0] in1_temp;
wire [2*WIDTH-1:0] in2_temp;
wire [2*WIDTH-1:0] result_temp;

assign in1_temp = {{18{input_1[17]}},input_1};
assign in2_temp = {{18{input_2[17]}},input_2};

assign result_temp = in1_temp + in2_temp;
modulo #(.WIDTH(WIDTH)) mod_0 (.input_mod(result_temp),.output_mod(output_add));

endmodule