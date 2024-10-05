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
output[WIDTH-1:0] output_2

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

//first stage 
// radix naming : Radix_coreNumber_stage
Radix_2 #(.WIDTH(WIDTH)) Radix_1_0 (.input_1(input_1),.input_2(input_2),.output_1(output_Radix_1_1_0),.output_2(output_Radix_1_2_0)); 
Radix_2 #(.WIDTH(WIDTH)) Radix_2_0 (.input_1(input_3),.input_2(input_4),.output_1(output_Radix_2_1_0),.output_2(output_Radix_2_2_0)); 
Radix_2 #(.WIDTH(WIDTH)) Radix_3_0 (.input_1(input_5),.input_2(input_6),.output_1(output_Radix_3_1_0),.output_2(output_Radix_3_2_0)); 
Radix_2 #(.WIDTH(WIDTH)) Radix_4_0 (.input_1(input_7),.input_2(input_8),.output_1(output_Radix_4_1_0),.output_2(output_Radix_4_2_0)); 

//second stage
Radix_2 #(.WIDTH(WIDTH)) Radix_1_1 (.input_1(output_Radix_1_1_0),.input_2(output_Radix_2_1_0),.output_1(output_Radix_1_1_1),.output_2(output_Radix_1_2_1)); 
Radix_2 #(.WIDTH(WIDTH)) Radix_2_1 (.input_1(output_Radix_1_2_0),.input_2(output_Radix_2_2_0),.output_1(output_Radix_2_1_0),.output_2(output_Radix_2_1_1)); 
Radix_2 #(.WIDTH(WIDTH)) Radix_3_1 (.input_1(input_4),.input_2(input_5),.output_1(output_Radix_3_1_0),.output_2(output_Radix_3_2_0)); 
Radix_2 #(.WIDTH(WIDTH)) Radix_4_1 (.input_1(input_6),.input_2(input_7),.output_1(output_Radix_4_1_0),.output_2(output_Radix_4_2_0));

//third stage
Radix_2 #(.WIDTH(WIDTH)) Radix_1_0 (.input_1(input_1),.input_2(input_2),.output_1(output_Radix_1_1_0),.output_2(output_Radix_1_2_0)); 
Radix_2 #(.WIDTH(WIDTH)) Radix_2_0 (.input_1(input_3),.input_2(input_4),.output_1(output_Radix_2_1_0),.output_2(output_Radix_2_2_0)); 
Radix_2 #(.WIDTH(WIDTH)) Radix_3_0 (.input_1(input_5),.input_2(input_6),.output_1(output_Radix_3_1_0),.output_2(output_Radix_3_2_0)); 
Radix_2 #(.WIDTH(WIDTH)) Radix_4_0 (.input_1(input_7),.input_2(input_8),.output_1(output_Radix_4_1_0),.output_2(output_Radix_4_2_0)); 


endmodule


