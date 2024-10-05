module modulo #(parameter width = 32)(
	input [width-1:0] in, 
	output [width-1:0] out
	);

	wire [width/2:0] msb;
	wire [width/2:0] lsb;
	wire [width/2:0] temp_out;
	wire [width-1:0] temp_in;
	wire [width/2:0] temp_sub;
	wire [width/2:0] temp_neg;
	wire [2:0] sel;

	assign temp_in = in[width-1] ? ~in+1:in;		// Change negative input to positive
	// Seperate 16 bit msb and lsb
	assign msb = temp_in[width-1:width/2];
	assign lsb = temp_in[width/2-1:0];

	// Get the mode value using mod properties
	assign temp_sub = lsb - msb;

	// Selector if subtraction output overflows
	assign sel[2] = temp_sub[width/2] & temp_sub[0];
	// Selector for negative value
	assign sel[1] = in[width-1];
	// Selector for negative values check multiples of 65537
	assign sel[0] = temp_sub[0] | temp_sub[1] | temp_sub[2] | temp_sub[3] | temp_sub[4] | temp_sub[5] | temp_sub[6] | temp_sub[7] | temp_sub[8] | temp_sub[9] | temp_sub[10] | temp_sub[11] | temp_sub[12] | temp_sub[13] | temp_sub[14] | temp_sub[15];

	// Mux to determine negative value output
	assign temp_neg = sel[0]? 65537 - temp_sub : 17'h00000;
	// Mux to determine output
	assign out[width/2:0] = sel[2]? (sel[1]? {16'h0000, 1'b1} : {1'b1, 16'h0000}) : (sel[1]? temp_neg : temp_sub);

	// Concat output
	assign out[width-1:width/2+1] = {width/2{1'b0}};

endmodule