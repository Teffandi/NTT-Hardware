`timescale 1ns/1ps

module serial_combine_radix ();
	/****************************************************************************
    * Parameter
    ***************************************************************************/
	parameter WIDTH = 18;
	parameter psi = 4;
	parameter prime = 65537;

   /****************************************************************************
    * Signals
    ***************************************************************************/

   reg signed [WIDTH-1:0] in_stream;
   reg signed [WIDTH-1:0] w1_stream;
   reg signed [WIDTH-1:0] w2_stream;
   reg signed [WIDTH-1:0] w3_stream;
   reg [1:0] radix_mode;
   reg mode;
   reg streaming_mode;
   reg clock;

   wire signed[WIDTH-1:0] out_stream;

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

   /****************************************************************************
    * Generate Clock Signals
    ***************************************************************************/

   // 250 MHz clock
   initial clock = 1'b1;
   always #2 clock = ~clock;

   /****************************************************************************
    * Instantiate Modules
    ***************************************************************************/

   Combined_Radix #(.WIDTH(WIDTH)) uut (
      .input_core_stream (in_stream),
      .weight_1_stream (w1_stream),
      .weight_2_stream (w2_stream),
      .weight_3_stream (w3_stream),
      .radix_mode (radix_mode),
      .mode (mode),
      .streaming_mode (streaming_mode),
      .clock (clock),
      .output_core_stream (out_stream)
   );

   /****************************************************************************
    * Apply Stimulus
    ***************************************************************************/



   initial begin
		$dumpfile("wave.vcd");
		$dumpvars(0,serial_combine_radix);

      // Testing NTT Radix 8
      radix_mode = 2'b10;
      mode = 1'b0;
      streaming_mode = 1'b1;

		in1 = 0; in2 = 4; in3 = 2; in4 = 6;
		in5 = 1; in6 = 5; in7 = 3; in8 = 7;

      psi1 = 1; psi2 = 256;
		psi3 = 16; psi4 = 4096;
		psi5 = 4; psi6 = 1024;
		psi7 = 64; psi8 = 16384;

		w2 = 256;
		w1 = 16; w3 = 4096;

      #4;

      in_stream = in8;
      w1_stream = psi8;
      w2_stream = w2;
      w3_stream = w3;
      #4;

      in_stream = in7;
      w1_stream = psi7;
      w2_stream = 1;
      w3_stream = 1;
      #4;

      in_stream = in6;
      w1_stream = psi6;
      w2_stream = 1;
      w3_stream = w2;
      #4;

      in_stream = in5;
      w1_stream = psi5;
      w2_stream = 1;
      w3_stream = 1;
      #4;

      in_stream = in4;
      w1_stream = psi4;
      w2_stream = w2;
      w3_stream = w1;
      #4;

      in_stream = in3;
      w1_stream = psi3;
      w2_stream = 1;
      w3_stream = 1;
      #4;

      in_stream = in2;
      w1_stream = psi2;
      w2_stream = 1;
      w3_stream = 1;
      #4;

      in_stream = in1;
      w1_stream = psi1;
      w2_stream = 1;
      w3_stream = 1;
		#4;

      // Testing INTT Radix 8
      radix_mode = 2'b10;
      mode = 1'b1;
      streaming_mode = 1'b1;

      in1 = 14562; in2 = 36702;
      in3 = 59790; in4 = 24116;
      in5 = 63638; in6 = 16427; 
      in7 = 10492; in8 = 36421;

		// psi1 = 1;      psi5 = 65281;
		// psi2 = 49153;  psi6 = 65473;
		// psi3 = 61441;  psi7 = 65521;
		// psi4 = 64513;  psi8 = 65533;

      psi1 = 1;      psi5 = 65505;
		psi2 = 63489;  psi6 = 65529;
		psi3 = 65025;  psi7 = 65535;
		psi4 = 65409;  psi8 = 32768;

		w2 = 65281;
		w1 = 61441; w3 = 65521;

      #4;

      in_stream = in8;
      w1_stream = w3;
      w2_stream = w2;
      w3_stream = psi8;
      #4;

      in_stream = in7;
      w1_stream = 1;
      w2_stream = 1;
      w3_stream = psi4;
      #4;

      in_stream = in6;
      w1_stream = w1;
      w2_stream = w2;
      w3_stream = psi7;
      #4;

      in_stream = in5;
      w1_stream = 1;
      w2_stream = 1;
      w3_stream = psi3;
      #4;

      in_stream = in4;
      w1_stream = w2;
      w2_stream = 1;
      w3_stream = psi6;
      #4;

      in_stream = in3;
      w1_stream = 1;
      w2_stream = 1;
      w3_stream = psi2;
      #4;

      in_stream = in2;
      w1_stream = 1;
      w2_stream = 1;
      w3_stream = psi5;
      #4;

      in_stream = in1;
      w1_stream = 1;
      w2_stream = 1;
      w3_stream = psi1;
		#4;

      #4;
	
		// $display ("Result 1: %d ", out1);
		// $display ("Result 2: %d ", out2);
		// $display ("Result 3: %d ", out3);
		// $display ("Result 4: %d ", out4);
		// $display ("Result 5: %d ", out5);
		// $display ("Result 6: %d ", out6);
		// $display ("Result 7: %d ", out7);
		// $display ("Result 8: %d ", out8);
      // $display ("Finished NTT\n============\n");
      // #1;

      // in1 = 14562; in5 = 63638; 
      // in3 = 59790; in7 = 10492;
		// in2 = 36702; in6 = 16427; 
      // in4 = 24116; in8 = 36421;

      // // [14562, 63638, 59790, 10492, 36702, 16427, 24116, 36421]
		
		// psi1 = 1;      psi5 = 65281;
		// psi2 = 49153;  psi6 = 65473;
		// psi5 = 61441;  psi6 = 65521;
		// psi7 = 64513;  psi8 = 65533;

		// w1 = 61441; w2 = 65281; w3 = 65521;

      // select_mode = 2'b10;
      // NTT_INTT_mode = 1'b1;

      // #1;
	
		// $display ("Result 1: %d ", out1);
		// $display ("Result 2: %d ", out2);
		// $display ("Result 3: %d ", out3);
		// $display ("Result 4: %d ", out4);
		// $display ("Result 5: %d ", out5);
		// $display ("Result 6: %d ", out6);
		// $display ("Result 7: %d ", out7);
		// $display ("Result 8: %d ", out8);
      // $display ("Finished INTT\n============\n");

      // #1;

		
      $finish;

   end

endmodule
