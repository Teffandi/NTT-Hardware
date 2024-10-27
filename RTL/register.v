module register #(parameter WIDTH = 18) (
    input wire clock,         // Clock input
    input wire rst_n,      // Active-low reset
    input wire [WIDTH-1:0] d, // Data input
    output reg [WIDTH-1:0] q  // Data output
);

    always @(posedge clock or negedge rst_n) begin
        if (rst_n) begin
            q <= {WIDTH{1'b0}}; // Reset the register to 0
        end else begin
            q <= d; // Load the input data into the register
        end
    end

endmodule
