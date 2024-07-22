`timescale 1ns/1ps

module modulo_tb #(parameter width = 32)();

   /****************************************************************************
    * Signals
    ***************************************************************************/

   reg [width-1:0] in;
   wire [width-1:0] out;

   /****************************************************************************
    * Generate Clock Signals
    ***************************************************************************/


   /****************************************************************************
    * Instantiate Modules
    ***************************************************************************/

   modulo uut (
      .in		(in),
      .out  	(out)
   );

   /****************************************************************************
    * Apply Stimulus
    ***************************************************************************/

   initial begin
		$display ("Testing value < 65537");
      for (integer i=7; i < 65537; i = i * 3) begin
			in = i;
			#1;
			$display ("%b (%d) mod 65537 = %b (%d)", in, in, out, out);
		end

		#1 $display ("\nTesting value >= 65536");
		for (integer i=65536; i < 65546; i = i + 1) begin
			in = i;
			#1;
			$display ("%b (%d) mod 65537 = %b (%d)", in, in, out, out);
		end

		#1 $display ("\nTesting value >= 131073");
		for (integer i=131073; i < 131078; i = i + 1) begin
			in = i;
			#1;
			$display ("%b (%d) mod 65537 = %b (%d)", in, in, out, out);
		end

		#1 $display ("\nTesting negative values > -65534");
		for (integer i=0; i > -10; i = i - 1) begin
			in = i;
			#1;
			$display ("%b (%d) mod 65537 = %b (%d)", i, i, out, out);
		end

		#1 $display ("\nTesting negative values from -65535");
		for (integer i=-65535; i > -65546; i = i - 1) begin
			in = i;
			#1;
			$display ("%b (%d) mod 65537 = %b (%d)", i, i, out, out);
		end

      $finish;

   end

endmodule
