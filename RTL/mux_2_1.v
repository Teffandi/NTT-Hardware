
module mux_2_1 #(parameter WIDTH = 18)(
    
   input [WIDTH-1:0] input_1, 
   input [WIDTH-1:0] input_2,
   input  select,
   output reg [WIDTH-1:0] out
);

 always @(*) begin
case (select)
    1'b0 : out = input_1;
    1'b1 : out = input_2;

endcase
end

endmodule