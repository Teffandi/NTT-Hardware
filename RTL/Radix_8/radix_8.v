
module radix_4 #(`include "parameter.vh")(
   input [width-1:0] input_1, 
   input [width-1:0] input_2,
   input [width-1:0] input_3,
   input [width-1:0] input_4,
   input [width-1:0] input_5, 
   input [width-1:0] input_6,
   input [width-1:0] input_7,
   input [width-1:0] input_8,
   input [width-1:0] input_twiddle_2,
   input [width-1:0] input_twiddle_3,
   input [width-1:0] input_twiddle_4,
   input [width-1:0] input_twiddle_5,
   input [width-1:0] input_twiddle_6,
   input [width-1:0] input_twiddle_7,
   input [width-1:0] input_twiddle_8,
   input  select, //0 for NTT and 1 for INTT

   output [width-1:0] output_1,
   output [width-1:0] output_2,
   output [width-1:0] output_3,
   output [width-1:0] output_4
   output [width-1:0] output_5,
   output [width-1:0] output_6,
   output [width-1:0] output_7,
   output [width-1:0] output_8

);

//=========================================================== butterfly structure begin
wire [width-1:0] temp_input_adder_1;
wire [width-1:0] temp_input_adder_2;
wire [width-1:0] temp_input_adder_3;
wire [width-1:0] temp_input_adder_4;
wire [width-1:0] temp_input_adder_5;
wire [width-1:0] temp_input_adder_6;
wire [width-1:0] temp_input_adder_7;
wire [width-1:0] temp_input_adder_8;

wire [width-1:0] temp_output_adder_1;
wire [width-1:0] temp_output_adder_2;
wire [width-1:0] temp_output_adder_3;
wire [width-1:0] temp_output_adder_4;
wire [width-1:0] temp_output_adder_5;
wire [width-1:0] temp_output_adder_6;
wire [width-1:0] temp_output_adder_7;
wire [width-1:0] temp_output_adder_8;

assign temp_output_adder_1 = temp_input_adder_1 + w2*temp_input_adder_2 + w3*temp_input_adder_3 + w4*temp_input_adder_4 + w5*temp_input_adder_5 + w6*temp_input_adder_6 + w7*temp_input_adder_7 + w8*temp_input_adder_8;
assign temp_output_adder_2 = temp_input_adder_1 + w4*temp_input_adder_2 + w7*temp_input_adder_3 - w2*temp_input_adder_4 - w5*temp_input_adder_5 - w8*temp_input_adder_6 + w3*temp_input_adder_7 + w6*temp_input_adder_8;
assign temp_output_adder_3 = temp_input_adder_1 + w6*temp_input_adder_2 - w3*temp_input_adder_3 - w8*temp_input_adder_4 + w5*temp_input_adder_5 - w2*temp_input_adder_6 - w7*temp_input_adder_7 + w4*temp_input_adder_8;
assign temp_output_adder_4 = temp_input_adder_1 + w8*temp_input_adder_2 - w7*temp_input_adder_3 + w6*temp_input_adder_4 - w5*temp_input_adder_5 + w4*temp_input_adder_6 - w3*temp_input_adder_7 + w2*temp_input_adder_8;
assign temp_output_adder_5 = temp_input_adder_1 - w2*temp_input_adder_2 + w3*temp_input_adder_3 - w4*temp_input_adder_4 + w5*temp_input_adder_5 - w6*temp_input_adder_6 + w7*temp_input_adder_7 - w8*temp_input_adder_8;
assign temp_output_adder_6 = temp_input_adder_1 - w4*temp_input_adder_2 + w7*temp_input_adder_3 + w2*temp_input_adder_4 - w5*temp_input_adder_5 + w8*temp_input_adder_6 + w3*temp_input_adder_7 - w6*temp_input_adder_8;
assign temp_output_adder_7 = temp_input_adder_1 - w6*temp_input_adder_2 - w3*temp_input_adder_3 + w8*temp_input_adder_4 + w5*temp_input_adder_5 + w2*temp_input_adder_6 - w7*temp_input_adder_7 - w4*temp_input_adder_8;
assign temp_output_adder_8 = temp_input_adder_1 - w8*temp_input_adder_2 - w7*temp_input_adder_3 - w6*temp_input_adder_4 - w5*temp_input_adder_5 - w4*temp_input_adder_6 - w3*temp_input_adder_7 - w2*temp_input_adder_8;
//=========================================================== butterfly structure end


//=========================================================== core structure begin
assign temp_input_adder_1 = input_1;
assign output_1 = temp_output_adder_1;

mode_switch mode_switch_0 (.input_switch(input_2),.twiddle_factor(input_twiddle_2),.butterfly_output(temp_output_adder_2),.select(select),.butterfly_input(temp_input_adder_2),.output_switch(output_2));
mode_switch mode_switch_1 (.input_switch(input_3),.twiddle_factor(input_twiddle_3),.butterfly_output(temp_output_adder_3),.select(select),.butterfly_input(temp_input_adder_3),.output_switch(output_3));
mode_switch mode_switch_2 (.input_switch(input_4),.twiddle_factor(input_twiddle_4),.butterfly_output(temp_output_adder_4),.select(select),.butterfly_input(temp_input_adder_4),.output_switch(output_4));
mode_switch mode_switch_3 (.input_switch(input_5),.twiddle_factor(input_twiddle_5),.butterfly_output(temp_output_adder_5),.select(select),.butterfly_input(temp_input_adder_5),.output_switch(output_5));
mode_switch mode_switch_4 (.input_switch(input_6),.twiddle_factor(input_twiddle_6),.butterfly_output(temp_output_adder_6),.select(select),.butterfly_input(temp_input_adder_6),.output_switch(output_6));
mode_switch mode_switch_5 (.input_switch(input_7),.twiddle_factor(input_twiddle_7),.butterfly_output(temp_output_adder_7),.select(select),.butterfly_input(temp_input_adder_7),.output_switch(output_7));
mode_switch mode_switch_6 (.input_switch(input_8),.twiddle_factor(input_twiddle_8),.butterfly_output(temp_output_adder_8),.select(select),.butterfly_input(temp_input_adder_8),.output_switch(output_8));

//=========================================================== core structure end

endmodule
