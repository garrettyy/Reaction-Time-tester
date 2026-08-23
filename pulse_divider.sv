`timescale 1ns / 1ps
module pulse_divider #(
    parameter DIVISOR = 100000
) (
    input logic clk_in,
    input logic rst,
    output logic clk_out // This is now a 1-cycle ENABLE PULSE
);

logic [$clog2(DIVISOR)-1:0] counter;

always_ff @(posedge clk_in or posedge rst) begin
    if (rst) begin
        counter <= '0;
        clk_out <= '0;
    end 
    else begin
        // Count to DIVISOR - 1 (e.g. 99,999)
        if (counter == DIVISOR - 1) begin
            clk_out <= 1'b1; // Pulse High for exactly 1 cycle
            counter <= '0;
        end
        else begin
            clk_out <= 1'b0; // Stay Low the rest of the time
            counter <= counter + 1;
        end
    end
end
endmodule
