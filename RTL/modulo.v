module modulo #(parameter width = 32)(
	input [width-1:0] in, 
	output [width-1:0] out
);

wire [width/2-1:0] msb;
wire [width/2-1:0] lsb;

assign msb = in[width-1:width/2];
assign lsb = in[width/2-1:0];

assign out[width/2-1:0] = lsb - msb;
assign out[width-1:width/2] = {width/2{1'b0}};


endmodule