`timescale 1ns / 1ps

module clock_divider #(
    parameter DIVISOR = 100000
) (
    input logic clk_in,
    input logic rst,
    output logic clk_out
);

localparam half_count = DIVISOR / 2;
logic [$clog2(half_count)-1:0] counter;

always_ff @(posedge clk_in or posedge rst) begin
    if (rst == 1'd1) begin
        counter <= '0;
        clk_out <= '0;
    end 
    else begin
        if (counter == half_count - 1) begin
            clk_out <= ~clk_out;
            counter <= '0;
        end
        else begin
            counter <= counter + '1;
        end
    end
end

endmodule