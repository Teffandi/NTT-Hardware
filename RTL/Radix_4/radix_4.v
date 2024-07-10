
module radix_4 #(`include "radix_2_parameter.vh")(
   input [width-1:0] input_1, 
   input [width-1:0] input_2,
   input [width-1:0] input_3,
   input [width-1:0] input_4,
   input [width-1:0] input_twiddle_1,
   input [width-1:0] input_twiddle_2,
   input [width-1:0] input_twiddle_3,
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

assign temp_output_adder_1 = temp_input_adder_1 + temp_input_adder_2 + temp_input_adder_3 + temp_input_adder_4;
assign temp_output_adder_2 = temp_input_adder_1 - temp_input_adder_2 - temp_input_adder_3 + temp_input_adder_4;
assign temp_output_adder_3 = temp_input_adder_1 - temp_input_adder_2 + temp_input_adder_3 - temp_input_adder_4;
assign temp_output_adder_4 = temp_input_adder_1 + temp_input_adder_2 - temp_input_adder_3 - temp_input_adder_4;

//=========================================================== butterfly structure end


//=========================================================== multiplier structure begin
wire [width-1:0] temp_input_mult_0;
wire [width-1:0] temp_output_mult_0;

mult mult_0 (.Operand_1(temp_input_mult_0),.Operand_2(input_twiddle),.output_mult(temp_output_mult_0));
//=========================================================== multiplier structure end


//=========================================================== core structure begin
mux_2_1 mux_0(.input_1(temp_output_mult_0),.input_2(input_2),.select(select),.out(temp_input_adder_2));
mux_2_1 mux_1(.input_1(input_2),.input_2(temp_output_adder_2),.select(select),.out(temp_input_mult_0));
mux_2_1 mux_2(.input_1(temp_output_adder_2),.input_2(temp_output_mult_0),.select(select),.out(output_2));
assign output_1 = temp_output_adder_1;
assign temp_input_adder_1 = input_1;
//=========================================================== core structure end

endmodule
