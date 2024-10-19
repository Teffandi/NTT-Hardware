`timescale 1ns/1ps

module combined_radix_tb ();
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
		.psi_5		(psi5),.psi_6		   (psi6),.psi_7		   (psi7),.psi_8		   (psi8),

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
		$dumpvars(0,combined_radix_tb);

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
	
		$display ("Result 1: %d ", out1);
		$display ("Result 2: %d ", out2);
		$display ("Result 3: %d ", out3);
		$display ("Result 4: %d ", out4);
		$display ("Result 5: %d ", out5);
		$display ("Result 6: %d ", out6);
		$display ("Result 7: %d ", out7);
		$display ("Result 8: %d ", out8);
      $display ("Finished NTT\n============\n");
      #1;

      in1 = 14562; in5 = 63638; 
      in3 = 59790; in7 = 10492;
		in2 = 36702; in6 = 16427; 
      in4 = 24116; in8 = 36421;

      // [14562, 63638, 59790, 10492, 36702, 16427, 24116, 36421]
		
		psi1 = 1;      psi5 = 65281;
		psi2 = 49153;  psi6 = 65473;
		psi5 = 61441;  psi6 = 65521;
		psi7 = 64513;  psi8 = 65533;

		w1 = 61441; w2 = 65281; w3 = 65521;

      select_mode = 2'b10;
      NTT_INTT_mode = 1'b1;

      #1;
	
		$display ("Result 1: %d ", out1);
		$display ("Result 2: %d ", out2);
		$display ("Result 3: %d ", out3);
		$display ("Result 4: %d ", out4);
		$display ("Result 5: %d ", out5);
		$display ("Result 6: %d ", out6);
		$display ("Result 7: %d ", out7);
		$display ("Result 8: %d ", out8);
      $display ("Finished INTT\n============\n");

      #1;

		
      $finish;

   end

endmodule
