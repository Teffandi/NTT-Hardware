// Radix 8 for NTT

module Combined_Radix  #(parameter WIDTH = 18)(
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

//input mode
input [1:0] select_mode,
input NTT_INTT_mode, // 0 for NTT ,1 for INTT

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

//psi temporary for NTT
wire [WIDTH-1:0] psi_1_temp_NTT;
wire [WIDTH-1:0] psi_2_temp_NTT;
wire [WIDTH-1:0] psi_3_temp_NTT;
wire [WIDTH-1:0] psi_4_temp_NTT;
wire [WIDTH-1:0] psi_5_temp_NTT;
wire [WIDTH-1:0] psi_6_temp_NTT;
wire [WIDTH-1:0] psi_7_temp_NTT;
wire [WIDTH-1:0] psi_8_temp_NTT;


//psi temporary for INTT
wire [WIDTH-1:0] psi_1_temp_INTT;
wire [WIDTH-1:0] psi_2_temp_INTT;
wire [WIDTH-1:0] psi_3_temp_INTT;
wire [WIDTH-1:0] psi_4_temp_INTT;
wire [WIDTH-1:0] psi_5_temp_INTT;
wire [WIDTH-1:0] psi_6_temp_INTT;
wire [WIDTH-1:0] psi_7_temp_INTT;
wire [WIDTH-1:0] psi_8_temp_INTT;

// Psi Temporrary for NTT or INTT on second Stage
wire [WIDTH-1:0] psi_3_stage2;
wire [WIDTH-1:0] psi_4_stage2;

// Psi Temporrary for NTT or INTT on Third Stage
wire [WIDTH-1:0] psi_1_stage3;
wire [WIDTH-1:0] psi_2_stage3;


//temporary output
wire [WIDTH-1:0] output_1_temp;
wire [WIDTH-1:0] output_2_temp;
wire [WIDTH-1:0] output_3_temp;
wire [WIDTH-1:0] output_4_temp;
wire [WIDTH-1:0] output_5_temp;
wire [WIDTH-1:0] output_6_temp;
wire [WIDTH-1:0] output_7_temp;
wire [WIDTH-1:0] output_8_temp;

wire [2*WIDTH-1:0] output_1_temp_1;
wire [2*WIDTH-1:0] output_2_temp_2;
wire [2*WIDTH-1:0] output_3_temp_3;
wire [2*WIDTH-1:0] output_4_temp_4;
wire [2*WIDTH-1:0] output_5_temp_5;
wire [2*WIDTH-1:0] output_6_temp_6;
wire [2*WIDTH-1:0] output_7_temp_7;
wire [2*WIDTH-1:0] output_8_temp_8;


//first stage 
// radix naming : Radix_coreNumber_stage
Radix_2 #(.WIDTH(WIDTH)) Radix_1_0 (.input_1(input_1),.input_2(input_2),.weight_1(psi_1_temp_NTT),.weight_2(psi_2_temp_NTT),.output_1(output_Radix_1_1_0),.output_2(output_Radix_1_2_0)); 
Radix_2 #(.WIDTH(WIDTH)) Radix_2_0 (.input_1(input_3),.input_2(input_4),.weight_1(psi_3_temp_NTT),.weight_2(psi_4_temp_NTT),.output_1(output_Radix_2_1_0),.output_2(output_Radix_2_2_0)); 
Radix_2 #(.WIDTH(WIDTH)) Radix_3_0 (.input_1(input_5),.input_2(input_6),.weight_1(psi_5_temp_NTT),.weight_2(psi_6_temp_NTT),.output_1(output_Radix_3_1_0),.output_2(output_Radix_3_2_0)); 
Radix_2 #(.WIDTH(WIDTH)) Radix_4_0 (.input_1(input_7),.input_2(input_8),.weight_1(psi_7_temp_NTT),.weight_2(psi_8_temp_NTT),.output_1(output_Radix_4_1_0),.output_2(output_Radix_4_2_0)); 

//second stage
Radix_2 #(.WIDTH(WIDTH)) Radix_1_1 (.input_1(output_Radix_1_1_0),.input_2(output_Radix_2_1_0),.weight_1(18'd1),.weight_2(18'd1),.output_1(output_Radix_1_1_1),.output_2(output_Radix_1_2_1)); 
Radix_2 #(.WIDTH(WIDTH)) Radix_2_1 (.input_1(output_Radix_1_2_0),.input_2(output_Radix_2_2_0),.weight_1(18'd1),.weight_2(w_2_8),.output_1(output_Radix_2_1_1),.output_2(output_Radix_2_2_1)); 
Radix_2 #(.WIDTH(WIDTH)) Radix_3_1 (.input_1(output_Radix_3_1_0),.input_2(output_Radix_4_1_0),.weight_1(18'd1),.weight_2(psi_3_stage2),.output_1(output_Radix_3_1_1),.output_2(output_Radix_3_2_1)); 
Radix_2 #(.WIDTH(WIDTH)) Radix_4_1 (.input_1(output_Radix_3_2_0),.input_2(output_Radix_4_2_0),.weight_1(18'd1),.weight_2(psi_4_stage2),.output_1(output_Radix_4_1_1),.output_2(output_Radix_4_2_1));

//third stage
Radix_2 #(.WIDTH(WIDTH)) Radix_1_2 (.input_1(output_Radix_1_1_1),.input_2(output_Radix_3_1_1),.weight_1(18'd1),.weight_2(18'd1),.output_1(output_Radix_1_1_2),.output_2(output_Radix_1_2_2)); 
Radix_2 #(.WIDTH(WIDTH)) Radix_2_2 (.input_1(output_Radix_2_1_1),.input_2(output_Radix_4_1_1),.weight_1(18'd1),.weight_2(psi_1_stage3),.output_1(output_Radix_2_1_2),.output_2(output_Radix_2_2_2)); 
Radix_2 #(.WIDTH(WIDTH)) Radix_3_2 (.input_1(output_Radix_1_2_1),.input_2(output_Radix_3_2_1),.weight_1(18'd1),.weight_2(w_2_8),.output_1(output_Radix_3_1_2),.output_2(output_Radix_3_2_2)); 
Radix_2 #(.WIDTH(WIDTH)) Radix_4_2 (.input_1(output_Radix_2_2_1),.input_2(output_Radix_4_2_1),.weight_1(18'd1),.weight_2(psi_2_stage3),.output_1(output_Radix_4_1_2),.output_2(output_Radix_4_2_2)); 

// Mux choosing weight for second stage stage
mux_2_1 #(.WIDTH(WIDTH)) mux_weight_1_stage2(.input_1(18'd1),.input_2(w_1_8),.select(NTT_INTT_mode),.out(psi_3_stage2));
mux_2_1 #(.WIDTH(WIDTH)) mux_weight_2_stage2(.input_1(w_2_8),.input_2(w_3_8),.select(NTT_INTT_mode),.out(psi_4_stage2));

// Mux choosing weight for second third stage
mux_2_1 #(.WIDTH(WIDTH)) mux_weight_1_stage3(.input_1(w_1_8),.input_2(18'd1),.select(NTT_INTT_mode),.out(psi_1_stage3));
mux_2_1 #(.WIDTH(WIDTH)) mux_weight_2_stage3(.input_1(w_3_8),.input_2(w_2_8),.select(NTT_INTT_mode),.out(psi_2_stage3));

//mux choosing output

//00 for R2 parallel 4 times
//01 for R4 parallel 2 times
//10 for R8 one time

mux_3_1 #(.WIDTH(WIDTH)) mux_0(.input_1(output_Radix_1_1_0),.input_2(output_Radix_1_1_1),.input_3(output_Radix_1_1_2),.select(select_mode),.out(output_1_temp));
mux_3_1 #(.WIDTH(WIDTH)) mux_1(.input_1(output_Radix_1_2_0),.input_2(output_Radix_2_1_1),.input_3(output_Radix_2_1_2),.select(select_mode),.out(output_2_temp));
mux_3_1 #(.WIDTH(WIDTH)) mux_2(.input_1(output_Radix_2_1_0),.input_2(output_Radix_1_2_1),.input_3(output_Radix_3_1_2),.select(select_mode),.out(output_3_temp));
mux_3_1 #(.WIDTH(WIDTH)) mux_3(.input_1(output_Radix_2_2_0),.input_2(output_Radix_2_2_1),.input_3(output_Radix_4_1_2),.select(select_mode),.out(output_4_temp));

mux_3_1 #(.WIDTH(WIDTH)) mux_4(.input_1(output_Radix_3_1_0),.input_2(output_Radix_3_1_1),.input_3(output_Radix_1_2_2),.select(select_mode),.out(output_5_temp));
mux_3_1 #(.WIDTH(WIDTH)) mux_5(.input_1(output_Radix_3_2_0),.input_2(output_Radix_4_1_1),.input_3(output_Radix_2_2_2),.select(select_mode),.out(output_6_temp));
mux_3_1 #(.WIDTH(WIDTH)) mux_6(.input_1(output_Radix_4_1_0),.input_2(output_Radix_3_2_1),.input_3(output_Radix_3_2_2),.select(select_mode),.out(output_7_temp));
mux_3_1 #(.WIDTH(WIDTH)) mux_7(.input_1(output_Radix_4_2_0),.input_2(output_Radix_4_2_1),.input_3(output_Radix_4_2_2),.select(select_mode),.out(output_8_temp));

// choosing between NTT and INTT mode operation
// NTT handling
mux_2_1 #(.WIDTH(WIDTH)) mux_8(.input_1(psi_1),.input_2(18'd1),.select(NTT_INTT_mode),.out(psi_1_temp_NTT));
mux_2_1 #(.WIDTH(WIDTH)) mux_9(.input_1(psi_2),.input_2(18'd1),.select(NTT_INTT_mode),.out(psi_2_temp_NTT));
mux_2_1 #(.WIDTH(WIDTH)) mux_10(.input_1(psi_3),.input_2(18'd1),.select(NTT_INTT_mode),.out(psi_3_temp_NTT));
mux_2_1 #(.WIDTH(WIDTH)) mux_11(.input_1(psi_4),.input_2(18'd1),.select(NTT_INTT_mode),.out(psi_4_temp_NTT));
mux_2_1 #(.WIDTH(WIDTH)) mux_12(.input_1(psi_5),.input_2(18'd1),.select(NTT_INTT_mode),.out(psi_5_temp_NTT));
mux_2_1 #(.WIDTH(WIDTH)) mux_13(.input_1(psi_6),.input_2(18'd1),.select(NTT_INTT_mode),.out(psi_6_temp_NTT));
mux_2_1 #(.WIDTH(WIDTH)) mux_14(.input_1(psi_7),.input_2(18'd1),.select(NTT_INTT_mode),.out(psi_7_temp_NTT));
mux_2_1 #(.WIDTH(WIDTH)) mux_15(.input_1(psi_8),.input_2(18'd1),.select(NTT_INTT_mode),.out(psi_8_temp_NTT));

//INTT handling
mux_2_1 #(.WIDTH(WIDTH)) mux_16(.input_1(psi_1),.input_2(18'd1),.select(~NTT_INTT_mode),.out(psi_1_temp_INTT));
mux_2_1 #(.WIDTH(WIDTH)) mux_17(.input_1(psi_2),.input_2(18'd1),.select(~NTT_INTT_mode),.out(psi_2_temp_INTT));
mux_2_1 #(.WIDTH(WIDTH)) mux_18(.input_1(psi_3),.input_2(18'd1),.select(~NTT_INTT_mode),.out(psi_3_temp_INTT));
mux_2_1 #(.WIDTH(WIDTH)) mux_19(.input_1(psi_4),.input_2(18'd1),.select(~NTT_INTT_mode),.out(psi_4_temp_INTT));
mux_2_1 #(.WIDTH(WIDTH)) mux_20(.input_1(psi_5),.input_2(18'd1),.select(~NTT_INTT_mode),.out(psi_5_temp_INTT));
mux_2_1 #(.WIDTH(WIDTH)) mux_21(.input_1(psi_6),.input_2(18'd1),.select(~NTT_INTT_mode),.out(psi_6_temp_INTT));
mux_2_1 #(.WIDTH(WIDTH)) mux_22(.input_1(psi_7),.input_2(18'd1),.select(~NTT_INTT_mode),.out(psi_7_temp_INTT));
mux_2_1 #(.WIDTH(WIDTH)) mux_23(.input_1(psi_8),.input_2(18'd1),.select(~NTT_INTT_mode),.out(psi_8_temp_INTT));

//multplication for intt
mult #(.WIDTH(WIDTH)) mult_0_intt (.input_1(output_1_temp),.input_2(psi_1_temp_INTT),.output_mult(output_1_temp_1));
mult #(.WIDTH(WIDTH)) mult_1_intt (.input_1(output_2_temp),.input_2(psi_5_temp_INTT),.output_mult(output_2_temp_2));
mult #(.WIDTH(WIDTH)) mult_2_intt (.input_1(output_3_temp),.input_2(psi_2_temp_INTT),.output_mult(output_3_temp_3));
mult #(.WIDTH(WIDTH)) mult_3_intt (.input_1(output_4_temp),.input_2(psi_6_temp_INTT),.output_mult(output_4_temp_4));
mult #(.WIDTH(WIDTH)) mult_4_intt (.input_1(output_5_temp),.input_2(psi_3_temp_INTT),.output_mult(output_5_temp_5));
mult #(.WIDTH(WIDTH)) mult_5_intt (.input_1(output_6_temp),.input_2(psi_7_temp_INTT),.output_mult(output_6_temp_6));
mult #(.WIDTH(WIDTH)) mult_6_intt (.input_1(output_7_temp),.input_2(psi_4_temp_INTT),.output_mult(output_7_temp_7));
mult #(.WIDTH(WIDTH)) mult_7_intt (.input_1(output_8_temp),.input_2(psi_8_temp_INTT),.output_mult(output_8_temp_8));

modulo #(.WIDTH(WIDTH)) mod_out_1 (.input_mod(output_1_temp_1),.output_mod(output_1));
modulo #(.WIDTH(WIDTH)) mod_out_2 (.input_mod(output_2_temp_2),.output_mod(output_2));
modulo #(.WIDTH(WIDTH)) mod_out_3 (.input_mod(output_3_temp_3),.output_mod(output_3));
modulo #(.WIDTH(WIDTH)) mod_out_4 (.input_mod(output_4_temp_4),.output_mod(output_4));
modulo #(.WIDTH(WIDTH)) mod_out_5 (.input_mod(output_5_temp_5),.output_mod(output_5));
modulo #(.WIDTH(WIDTH)) mod_out_6 (.input_mod(output_6_temp_6),.output_mod(output_6));
modulo #(.WIDTH(WIDTH)) mod_out_7 (.input_mod(output_7_temp_7),.output_mod(output_7));
modulo #(.WIDTH(WIDTH)) mod_out_8 (.input_mod(output_8_temp_8),.output_mod(output_8));


endmodule

