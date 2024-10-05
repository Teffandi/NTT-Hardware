// Radix 8 for NTT

module Radix_8  #(parameter WIDTH = 18)(
// data in
input [WIDTH-1:0] input_1,
input [WIDTH-1:0] input_2,
input [WIDTH-1:0] input_3,
input [WIDTH-1:0] input_4,
input [WIDTH-1:0] input_5,
input [WIDTH-1:0] input_6,
input [WIDTH-1:0] input_7,
input [WIDTH-1:0] input_8,
// psi weight 
input [WIDTH-1:0] psi_1,
input [WIDTH-1:0] psi_2,
input [WIDTH-1:0] psi_3,
input [WIDTH-1:0] psi_4,
input [WIDTH-1:0] psi_5,
input [WIDTH-1:0] psi_6,
input [WIDTH-1:0] psi_7,
input [WIDTH-1:0] psi_8,
// w weight for butterfly structure
input [WIDTH-1:0] w_0_8,
input [WIDTH-1:0] w_1_8,
input [WIDTH-1:0] w_2_8,
input [WIDTH-1:0] w_3_8,

//output 
output[WIDTH-1:0] output_1,
output[WIDTH-1:0] output_2,
output[WIDTH-1:0] output_3,
output[WIDTH-1:0] output_4,
output[WIDTH-1:0] output_5,
output[WIDTH-1:0] output_6,
output[WIDTH-1:0] output_7,
output[WIDTH-1:0] output_8

);

//wire naming convention : output_Radix_blockNumber_output_stage

//for first stage
wire [WIDTH-1:0] output_Radix_1_1_0;
wire [WIDTH-1:0] output_Radix_1_2_0;
wire [WIDTH-1:0] output_Radix_2_1_0;
wire [WIDTH-1:0] output_Radix_2_2_0;
wire [WIDTH-1:0] output_Radix_3_1_0;
wire [WIDTH-1:0] output_Radix_3_2_0;
wire [WIDTH-1:0] output_Radix_4_1_0;
wire [WIDTH-1:0] output_Radix_4_2_0;
//for second stage
wire [WIDTH-1:0] output_Radix_1_1_1;
wire [WIDTH-1:0] output_Radix_1_2_1;
wire [WIDTH-1:0] output_Radix_2_1_1;
wire [WIDTH-1:0] output_Radix_2_2_1;
wire [WIDTH-1:0] output_Radix_3_1_1;
wire [WIDTH-1:0] output_Radix_3_2_1;
wire [WIDTH-1:0] output_Radix_4_1_1;
wire [WIDTH-1:0] output_Radix_4_2_1;
//for third stage
wire [WIDTH-1:0] output_Radix_1_1_2;
wire [WIDTH-1:0] output_Radix_1_2_2;
wire [WIDTH-1:0] output_Radix_2_1_2;
wire [WIDTH-1:0] output_Radix_2_2_2;
wire [WIDTH-1:0] output_Radix_3_1_2;
wire [WIDTH-1:0] output_Radix_3_2_2;
wire [WIDTH-1:0] output_Radix_4_1_2;
wire [WIDTH-1:0] output_Radix_4_2_2;

//first stage 
// radix naming : Radix_coreNumber_stage
Radix_2 #(.WIDTH(WIDTH)) Radix_1_0 (.input_1(input_1),.input_2(input_2),.weight_1(psi_1),.weight_2(psi_2),.output_1(output_Radix_1_1_0),.output_2(output_Radix_1_2_0)); 
Radix_2 #(.WIDTH(WIDTH)) Radix_2_0 (.input_1(input_3),.input_2(input_4),.weight_1(psi_3),.weight_2(psi_4),.output_1(output_Radix_2_1_0),.output_2(output_Radix_2_2_0)); 
Radix_2 #(.WIDTH(WIDTH)) Radix_3_0 (.input_1(input_5),.input_2(input_6),.weight_1(psi_5),.weight_2(psi_6),.output_1(output_Radix_3_1_0),.output_2(output_Radix_3_2_0)); 
Radix_2 #(.WIDTH(WIDTH)) Radix_4_0 (.input_1(input_7),.input_2(input_8),.weight_1(psi_7),.weight_2(psi_8),.output_1(output_Radix_4_1_0),.output_2(output_Radix_4_2_0)); 

//second stage
Radix_2 #(.WIDTH(WIDTH)) Radix_1_1 (.input_1(output_Radix_1_1_0),.input_2(output_Radix_2_1_0),.weight_1(psi_1),.weight_2(w_0_8),.output_1(output_Radix_1_1_1),.output_2(output_Radix_1_2_1)); 
Radix_2 #(.WIDTH(WIDTH)) Radix_2_1 (.input_1(output_Radix_1_2_0),.input_2(output_Radix_2_2_0),.weight_1(psi_1),.weight_2(w_2_8),.output_1(output_Radix_2_1_1),.output_2(output_Radix_2_2_1)); 
Radix_2 #(.WIDTH(WIDTH)) Radix_3_1 (.input_1(output_Radix_3_1_0),.input_2(output_Radix_4_1_0),.weight_1(psi_1),.weight_2(w_0_8),.output_1(output_Radix_3_1_1),.output_2(output_Radix_3_2_1)); 
Radix_2 #(.WIDTH(WIDTH)) Radix_4_1 (.input_1(output_Radix_3_2_0),.input_2(output_Radix_4_2_0),.weight_1(psi_1),.weight_2(w_2_8),.output_1(output_Radix_4_1_1),.output_2(output_Radix_4_2_1));

//third stage
Radix_2 #(.WIDTH(WIDTH)) Radix_1_2 (.input_1(output_Radix_1_1_1),.input_2(output_Radix_3_1_1),.weight_1(psi_1),.weight_2(w_0_8),.output_1(output_Radix_1_1_2),.output_2(output_Radix_1_2_2)); 
Radix_2 #(.WIDTH(WIDTH)) Radix_2_2 (.input_1(output_Radix_1_2_1),.input_2(output_Radix_3_2_1),.weight_1(psi_1),.weight_2(w_1_8),.output_1(output_Radix_2_1_2),.output_2(output_Radix_2_2_2)); 
Radix_2 #(.WIDTH(WIDTH)) Radix_3_2 (.input_1(output_Radix_2_1_1),.input_2(output_Radix_4_1_1),.weight_1(psi_1),.weight_2(w_2_8),.output_1(output_Radix_3_1_2),.output_2(output_Radix_3_2_2)); 
Radix_2 #(.WIDTH(WIDTH)) Radix_4_2 (.input_1(output_Radix_2_2_1),.input_2(output_Radix_4_2_1),.weight_1(psi_1),.weight_2(w_3_8),.output_1(output_Radix_4_1_2),.output_2(output_Radix_4_2_2)); 

assign output_1 = output_Radix_1_1_2;
assign output_2 = output_Radix_1_2_2;
assign output_3 = output_Radix_2_1_2;
assign output_4 = output_Radix_2_2_2;
assign output_5 = output_Radix_3_1_2;
assign output_6 = output_Radix_3_2_2;
assign output_7 = output_Radix_4_1_2;
assign output_8 = output_Radix_4_2_2;

endmodule

