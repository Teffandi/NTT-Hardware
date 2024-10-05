
module mux_3_1 #(parameter WIDTH = 18)(
    
   input [WIDTH-1:0] input_1, 
   input [WIDTH-1:0] input_2,
   input [WIDTH-1:0] input_3,
   input [1:0] select,
   output reg [WIDTH-1:0] out
);

 always @(*) begin
case (select)
    2'b00 : out = input_1;
    2'b01 : out = input_2;
    2'b10 : out = input_3;
    2'b11 : out = 'd0;

endcase
end

endmodule