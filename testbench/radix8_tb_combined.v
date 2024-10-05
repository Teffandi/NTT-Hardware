`timescale 1ns/1ps

module radix8_combined_tb ();
	/****************************************************************************
    * Parameter
    ***************************************************************************/
	parameter WIDTH = 18;
	parameter psi = 4;
	parameter prime = 65537;

   /****************************************************************************
    * Signals
    ***************************************************************************/

   reg signed [WIDTH-1:0] in1;
   reg signed [WIDTH-1:0] in2;
   reg signed [WIDTH-1:0] in3;
   reg signed [WIDTH-1:0] in4;
   reg signed [WIDTH-1:0] in5;
   reg signed [WIDTH-1:0] in6;
   reg signed [WIDTH-1:0] in7;
   reg signed [WIDTH-1:0] in8;
   reg signed [WIDTH-1:0] psi1;
   reg signed [WIDTH-1:0] psi2;
   reg signed [WIDTH-1:0] psi3;
   reg signed [WIDTH-1:0] psi4;
   reg signed [WIDTH-1:0] psi5;
   reg signed [WIDTH-1:0] psi6;
   reg signed [WIDTH-1:0] psi7;
   reg signed [WIDTH-1:0] psi8;
   reg signed [WIDTH-1:0] w0;
   reg signed [WIDTH-1:0] w1;
   reg signed [WIDTH-1:0] w2;
   reg signed [WIDTH-1:0] w3;
   reg [1:0] select_mode;
   reg NTT_INTT_mode;

   wire signed[WIDTH-1:0] out1;
   wire signed[WIDTH-1:0] out2;
   wire signed[WIDTH-1:0] out3;
   wire signed[WIDTH-1:0] out4;
   wire signed[WIDTH-1:0] out5;
   wire signed[WIDTH-1:0] out6;
   wire signed[WIDTH-1:0] out7;
   wire signed[WIDTH-1:0] out8;

   /****************************************************************************
    * Generate Clock Signals
    ***************************************************************************/

   /****************************************************************************
    * Instantiate Modules
    ***************************************************************************/

   Combined_Radix #(.WIDTH(WIDTH)) uut (
      .input_1		(in1), .input_2		(in2), .input_3		(in3), .input_4		(in4),
		.input_5		(in5), .input_6		(in6), .input_7		(in7), .input_8		(in8),
		.psi_1		(psi1),.psi_2			(psi2),.psi_3			(psi3),.psi_4			(psi4),
		.psi_5		(psi5),
		.psi_6		(psi6),
		.psi_7		(psi7),
		.psi_8		(psi8),
		.w_0_8		(w0),
		.w_1_8		(w1),
		.w_2_8		(w2),
		.w_3_8		(w3),
      .select_mode (select_mode),
      .NTT_INTT_mode(NTT_INTT_mode),      


		.output_1	(out1),
		.output_2	(out2),
		.output_3	(out3),
		.output_4	(out4),
		.output_5	(out5),
		.output_6	(out6),
		.output_7	(out7),
		.output_8	(out8)
   );

   /****************************************************************************
    * Apply Stimulus
    ***************************************************************************/

   initial begin
		$dumpfile("wave.vcd");
		$dumpvars(0,radix8_combined_tb);

		in1 = 0; in2 = 4; in3 = 2; in4 = 6;
		in5 = 1; in6 = 5; in7 = 3; in8 = 7;
		
		psi1 = 1; psi2 = 256;
		psi3 = 16; psi4 = 4096;
		psi5 = 4; psi6 = 1024;
		psi7 = 64; psi8 = 16384;

		w2 = 256;
		w1 = 16; w3 = 4096;

      select_mode = 2'b10;
      NTT_INTT_mode = 1'b0;

		#1;
	
		$display ("Result 1: %b (%d) ", out1%prime, out1%prime);
		$display ("Result 2: %b (%d) ", out2%prime, out2%prime);
		$display ("Result 3: %b (%d) ", out3%prime, out3%prime);
		$display ("Result 4: %b (%d) ", out4%prime, out4%prime);
		$display ("Result 5: %b (%d) ", out5%prime, out5%prime);
		$display ("Result 6: %b (%d) ", out6%prime, out6%prime);
		$display ("Result 7: %b (%d) ", out7%prime, out7%prime);
		$display ("Result 8: %b (%d) ", out8%prime, out8%prime);

		
      $finish;

   end

endmodule
