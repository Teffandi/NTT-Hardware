module para_serial #(parameter WIDTH = 18)(
input clock,
input enable,
input [WIDTH-1:0]input_para_0,
input [WIDTH-1:0]input_para_1,
input [WIDTH-1:0]input_para_2,
input [WIDTH-1:0]input_para_3,
input [WIDTH-1:0]input_para_4,
input [WIDTH-1:0]input_para_5,
input [WIDTH-1:0]input_para_6,
input [WIDTH-1:0]input_para_7,
output reg [WIDTH-1:0]output_serial

);

reg [WIDTH-1:0]temp[7:0];

always @(negedge clock) begin

    if (enable) begin
        
        output_serial <= temp[7];
        temp[7] <= temp[6];
        temp[6] <= temp[5];
        temp[5] <= temp[4];
        temp[4] <= temp[3];
        temp[3] <= temp[2];
        temp[2] <= temp[1];
        temp[1] <= temp[0];
    
    end else begin
        temp[0] <= input_para_0;
        temp[1] <= input_para_1;
        temp[2] <= input_para_2;
        temp[3] <= input_para_3;
        temp[4] <= input_para_4;
        temp[5] <= input_para_5;
        temp[6] <= input_para_6;
        temp[7] <= input_para_7;

    end

end


endmodule
