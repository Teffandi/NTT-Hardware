module serial_para #(parameter WIDTH = 18)(
input [WIDTH-1:0]input_serial,
input clock,
input enable,
output [WIDTH-1:0]output_para_0,
output [WIDTH-1:0]output_para_1,
output [WIDTH-1:0]output_para_2,
output [WIDTH-1:0]output_para_3,
output [WIDTH-1:0]output_para_4,
output [WIDTH-1:0]output_para_5,
output [WIDTH-1:0]output_para_6,
output [WIDTH-1:0]output_para_7
);

reg [WIDTH-1:0]temp[7:0];

always @(negedge clock) begin

    if (enable) begin
        temp[0]<=input_serial;
        temp[1]<=temp[0];
        temp[2]<=temp[1];
        temp[3]<=temp[2];
        temp[4]<=temp[3];
        temp[5]<=temp[4];
        temp[6]<=temp[5];
        temp[7]<=temp[6];
    end

end

assign output_para_0 = temp[0];
assign output_para_1 = temp[1];
assign output_para_2 = temp[2];
assign output_para_3 = temp[3];
assign output_para_4 = temp[4];
assign output_para_5 = temp[5];
assign output_para_6 = temp[6];
assign output_para_7 = temp[7];

endmodule
