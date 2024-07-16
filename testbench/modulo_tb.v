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
      .in	(in),
      .out  (out)
   );

   /****************************************************************************
    * Apply Stimulus
    ***************************************************************************/

   initial begin
		$display ("Testing value < 65537");
      for (integer i=7; i < 65537; i = i * 3) begin
			in = i;
			#1;
			$display ("%d mod 65537 = %d", in, out);
		end

		#1 $display ("\nTesting value > 65537");
		for (integer i=65546; i < 65636; i = i + 4) begin
			in = i;
			#1;
			$display ("%d mod 65537 = %d", in, out);
		end

      $finish;

   end

endmodule
