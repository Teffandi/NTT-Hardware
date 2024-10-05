//implementation of modulus 
// change the m value accordingly (prime = 2**m+1)
//where data is between -2**2m and 2**2m
// this code is implemented as 2**16+1 fermat prime

module modulo #(parameter WIDTH = 18)(

   input [2*WIDTH-1:0] input_mod, 
   output reg [WIDTH-1:0] output_mod

);
parameter prime = 65537; //prime
parameter m = 16;

wire [WIDTH-1:0] temp_signal;
assign temp_signal = input_mod[m-1:0] - (input_mod>>m);

always@(*) begin

    if((prime>temp_signal)&&(temp_signal>=0)) output_mod = temp_signal;
    else if(prime<=temp_signal) output_mod = temp_signal - prime;
    else output_mod = temp_signal+prime;
end


endmodule