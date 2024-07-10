
module radix_2 #(`include "radix_2_parameter.vh")(
   input [width-1:0] input_1, 
   input [width-1:0] input_2,
   input [width-1:0] input_twiddle_1,
   input [width-1:0] input_twiddle_2,
   input  select, //0 for NTT and 1 for INTT
   output [width-1:0] output_1,
   output [width-1:0] output_2
);

//=========================================================== butterfly structure begin
wire [width-1:0] temp_input_adder_1;
wire [width-1:0] temp_input_adder_2;
wire [width-1:0] temp_output_adder_1;
wire [width-1:0] temp_output_adder_2;

adder_2 add_0(.Operand_1(temp_input_adder_1),.Operand_2(temp_input_adder_2),.mode(1'b0),.adder_output(temp_output_adder_1)); //add
adder_2 add_1(.Operand_1(temp_input_adder_1),.Operand_2(temp_input_adder_2),.mode(1'b1),.adder_output(temp_output_adder_2));//subtract
//=========================================================== butterfly structure end


//=========================================================== multiplier structure begin
wire [width-1:0] temp_input_mult_1;
wire [width-1:0] temp_input_mult_2;
wire [width-1:0] temp_output_mult_1;
wire [width-1:0] temp_output_mult_2;

mult mult_0(.Operand_1(temp_input_mult_1),.Operand_2(input_twiddle_1),.output_mult(temp_output_mult_1));
mult mult_1(.Operand_1(temp_input_mult_2),.Operand_2(input_twiddle_2),.output_mult(temp_output_mult_2));
//=========================================================== multiplier structure end


//=========================================================== core structure begin
mux_2_1 mux_0(.input_1(input_1),.input_2(temp_output_adder_1),.select(select),.out(temp_input_mult_1));
mux_2_1 mux_1(.input_1(temp_output_mult_1),.input_2(input_1),.select(select),.out(temp_input_adder_1));
mux_2_1 mux_2(.input_1(temp_output_mult_2),.input_2(input_2),.select(select),.out(temp_input_adder_2));
mux_2_1 mux_3(.input_1(input_2),.input_2(temp_output_adder_2),.select(select),.out(temp_input_mult_2));
mux_2_1 mux_4(.input_1(temp_output_adder_1),.input_2(temp_output_mult_1),.select(select),.out(output_1));
mux_2_1 mux_5(.input_1(temp_output_adder_2),.input_2(temp_output_mult_2),.select(select),.out(output_2));
//=========================================================== core structure end

endmodule
