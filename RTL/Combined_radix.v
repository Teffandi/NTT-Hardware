//Radix 2 consisted of upper and lower part
module Combined_Radix #(parameter WIDTH = 18)(
input [WIDTH-1:0] input_core_stream,
input [WIDTH-1:0] weight_1_stream,
input [WIDTH-1:0] weight_2_stream,
input [WIDTH-1:0] weight_3_stream,
input [1:0] radix_mode, //picking radix core
input mode, // picking NTT/INTT mode
input streaming_mode, // 1 for input stream 0 for output stream
input clock,
output [WIDTH-1:0] output_core_stream,

// TB only
output [WIDTH-1:0] output0,
output [WIDTH-1:0] output1,
output [WIDTH-1:0] output2,
output [WIDTH-1:0] output3,
output [WIDTH-1:0] output4,
output [WIDTH-1:0] output5,
output [WIDTH-1:0] output6,
output [WIDTH-1:0] output7
);

wire [WIDTH-1:0]T[7:0];
wire [WIDTH-1:0]R[7:0];
wire [WIDTH-1:0]Y[7:0];


wire [WIDTH-1:0] input_core [7:0];
wire [WIDTH-1:0] weight_1 [7:0];
wire [WIDTH-1:0] weight_2 [7:0];
wire [WIDTH-1:0] weight_3 [7:0];
wire [WIDTH-1:0] output_core [7:0];

//streaming data in
serial_para serial_para_0 (.input_serial(input_core_stream),.clock(clock),.enable(streaming_mode),.output_para_0(input_core[0]),.output_para_1(input_core[1]),.output_para_2(input_core[2]),.output_para_3(input_core[3]),.output_para_4(input_core[4]),.output_para_5(input_core[5]),.output_para_6(input_core[6]),.output_para_7(input_core[7]));
serial_para serial_para_1 (.input_serial(weight_1_stream),.clock(clock),.enable(streaming_mode),.output_para_0(weight_1[0]),.output_para_1(weight_1[1]),.output_para_2(weight_1[2]),.output_para_3(weight_1[3]),.output_para_4(weight_1[4]),.output_para_5(weight_1[5]),.output_para_6(weight_1[6]),.output_para_7(weight_1[7]));
serial_para serial_para_2 (.input_serial(weight_2_stream),.clock(clock),.enable(streaming_mode),.output_para_0(weight_2[0]),.output_para_1(weight_2[1]),.output_para_2(weight_2[2]),.output_para_3(weight_2[3]),.output_para_4(weight_2[4]),.output_para_5(weight_2[5]),.output_para_6(weight_2[6]),.output_para_7(weight_2[7]));
serial_para serial_para_3 (.input_serial(weight_3_stream),.clock(clock),.enable(streaming_mode),.output_para_0(weight_3[0]),.output_para_1(weight_3[1]),.output_para_2(weight_3[2]),.output_para_3(weight_3[3]),.output_para_4(weight_3[4]),.output_para_5(weight_3[5]),.output_para_6(weight_3[6]),.output_para_7(weight_3[7]));
//stream data out
para_serial para_serial_0 (.clock(clock),.enable(~streaming_mode),.input_para_0(output_core[0]),.input_para_1(output_core[1]),.input_para_2(output_core[2]),.input_para_3(output_core[3]),.input_para_4(output_core[4]),.input_para_5(output_core[5]),.input_para_6(output_core[6]),.input_para_7(output_core[7]),.output_serial(output_core_stream));


//first stage
Radix_2 #(.WIDTH(WIDTH)) Radix_block_0 (.input_1(input_core[0]),.input_2(input_core[1]),.weight_1(weight_1[0]),.weight_2(weight_1[1]),.mode(mode),.output_1(T[0]),.output_2(T[1]));
Radix_2 #(.WIDTH(WIDTH)) Radix_block_1 (.input_1(input_core[2]),.input_2(input_core[3]),.weight_1(weight_1[2]),.weight_2(weight_1[3]),.mode(mode),.output_1(T[2]),.output_2(T[3]));
Radix_2 #(.WIDTH(WIDTH)) Radix_block_2 (.input_1(input_core[4]),.input_2(input_core[5]),.weight_1(weight_1[4]),.weight_2(weight_1[5]),.mode(mode),.output_1(T[4]),.output_2(T[5]));
Radix_2 #(.WIDTH(WIDTH)) Radix_block_3 (.input_1(input_core[6]),.input_2(input_core[7]),.weight_1(weight_1[6]),.weight_2(weight_1[7]),.mode(mode),.output_1(T[6]),.output_2(T[7]));

//second stage
Radix_2 #(.WIDTH(WIDTH)) Radix_block_4 (.input_1(T[0]),.input_2(T[2]),.weight_1(weight_2[0]),.weight_2(weight_2[1]),.mode(mode),.output_1(R[0]),.output_2(R[2]));
Radix_2 #(.WIDTH(WIDTH)) Radix_block_5 (.input_1(T[1]),.input_2(T[3]),.weight_1(weight_2[2]),.weight_2(weight_2[3]),.mode(mode),.output_1(R[1]),.output_2(R[3]));
Radix_2 #(.WIDTH(WIDTH)) Radix_block_6 (.input_1(T[4]),.input_2(T[6]),.weight_1(weight_2[4]),.weight_2(weight_2[5]),.mode(mode),.output_1(R[4]),.output_2(R[6]));
Radix_2 #(.WIDTH(WIDTH)) Radix_block_7 (.input_1(T[5]),.input_2(T[7]),.weight_1(weight_2[6]),.weight_2(weight_2[7]),.mode(mode),.output_1(R[5]),.output_2(R[7]));

//third stage
Radix_2 #(.WIDTH(WIDTH)) Radix_block_8 (.input_1(R[0]),.input_2(R[4]),.weight_1(weight_3[0]),.weight_2(weight_3[1]),.mode(mode),.output_1(Y[0]),.output_2(Y[1]));
Radix_2 #(.WIDTH(WIDTH)) Radix_block_9 (.input_1(R[1]),.input_2(R[5]),.weight_1(weight_3[2]),.weight_2(weight_3[3]),.mode(mode),.output_1(Y[2]),.output_2(Y[3]));
Radix_2 #(.WIDTH(WIDTH)) Radix_block_10 (.input_1(R[2]),.input_2(R[6]),.weight_1(weight_3[4]),.weight_2(weight_3[5]),.mode(mode),.output_1(Y[4]),.output_2(Y[5]));
Radix_2 #(.WIDTH(WIDTH)) Radix_block_11 (.input_1(R[3]),.input_2(R[7]),.weight_1(weight_3[6]),.weight_2(weight_3[7]),.mode(mode),.output_1(Y[6]),.output_2(Y[7]));

//radix output selection and generation
genvar i;
generate
    for (i=0; i<=7; i=i+1) begin : mux_block // <-- example block name
    mux_3_1 mux_block(.input_1(T[i]),.input_2(R[i]),.input_3(Y[i]),.select(radix_mode),.out(output_core[i]));
end 
endgenerate

//TB_only
assign output0 = output_core[0];
assign output1 = output_core[1];
assign output2 = output_core[2];
assign output3 = output_core[3];
assign output4 = output_core[4];
assign output5 = output_core[5];
assign output6 = output_core[6];
assign output7 = output_core[7];


endmodule