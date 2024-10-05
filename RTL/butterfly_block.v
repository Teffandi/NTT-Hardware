
module butterfly_block #(parameter WIDTH = 18)(
   input [WIDTH-1:0] input_1, 
   input [WIDTH-1:0] input_2,
   output [WIDTH-1:0] output_1,
   output [WIDTH-1:0] output_2
);

wire [WIDTH*2-1:0]  temp_out1;
wire [WIDTH*2-1:0]  temp_out2;

assign temp_out1 = input_1 + input_2;
assign temp_out2 = input_1 - input_2;

modulo #(.WIDTH(WIDTH)) mod_0 (.input_mod(temp_out1),.output_mod(output_1));
modulo #(.WIDTH(WIDTH)) mod_1 (.input_mod(temp_out2),.output_mod(output_2));

endmodule
