
module butterfly_block #(parameter WIDTH = 18)(
   input [WIDTH-1:0] input_1, 
   input [WIDTH-1:0] input_2,
   output [width-1:0] output_1,
   output [width-1:0] output_2
);

assign output_1 = input_1 + input_2;
assign output_2 = input_1 - input_2;



endmodule
