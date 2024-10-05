
module radix_4 #(`include "parameter.vh")(
   input [width-1:0] input_1, 
   input [width-1:0] input_2,
   input [width-1:0] input_3,
   input [width-1:0] input_4,
   input [width-1:0] input_twiddle_2,
   input [width-1:0] input_twiddle_3,
   input [width-1:0] input_twiddle_4,
   input  select, //0 for NTT and 1 for INTT
   output [width-1:0] output_1,
   output [width-1:0] output_2,
   output [width-1:0] output_3,
   output [width-1:0] output_4

);

//=========================================================== butterfly structure begin
wire [width-1:0] temp_input_adder_1;
wire [width-1:0] temp_input_adder_2;
wire [width-1:0] temp_input_adder_3;
wire [width-1:0] temp_input_adder_4;
wire [width-1:0] temp_output_adder_1;
wire [width-1:0] temp_output_adder_2;
wire [width-1:0] temp_output_adder_3;
wire [width-1:0] temp_output_adder_4;

assign temp_output_adder_1 = temp_input_adder_1 + temp_input_adder_2*w2 + temp_input_adder_3*w3 + temp_input_adder_4*w4;
assign temp_output_adder_2 = temp_input_adder_1 - temp_input_adder_2*w3 - temp_input_adder_3*w2 + temp_input_adder_4*w1;
assign temp_output_adder_3 = temp_input_adder_1 - temp_input_adder_2*w1 + temp_input_adder_3*w2 - temp_input_adder_4*w3;
assign temp_output_adder_4 = temp_input_adder_1 + temp_input_adder_2*w3 - temp_input_adder_3*w2 - temp_input_adder_4*w3;
//=========================================================== butterfly structure end


//=========================================================== core structure begin
assign temp_input_adder_1 = input_1;
assign output_1 = temp_output_adder_1;

mode_switch mode_switch_0 (.input_switch(input_2),.twiddle_factor(input_twiddle_2),.butterfly_output(temp_output_adder_2),.select(select),.butterfly_input(temp_input_adder_2),.output_switch(output_2));
mode_switch mode_switch_1 (.input_switch(input_3),.twiddle_factor(input_twiddle_3),.butterfly_output(temp_output_adder_3),.select(select),.butterfly_input(temp_input_adder_3),.output_switch(output_3));
mode_switch mode_switch_2 (.input_switch(input_4),.twiddle_factor(input_twiddle_4),.butterfly_output(temp_output_adder_4),.select(select),.butterfly_input(temp_input_adder_4),.output_switch(output_4));
//=========================================================== core structure end

endmodule
