`timescale 1ns / 1ps

module random_number_generator (
    input logic clk,
    input logic rst,
    input logic generate_num,
    output logic [7:0] random_number
    );

logic feedback_bit;
logic [7:0] eight_bits = 8'b00000001;
assign random_number = eight_bits;

always_comb begin
    feedback_bit = eight_bits[7] ^ eight_bits[5] ^ eight_bits[4] ^ eight_bits[3];
end

always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        eight_bits <= 8'b00000001;
    end
    else begin
        if (generate_num) begin
            eight_bits <= {eight_bits[6:0], feedback_bit};
        end
    end
end

endmodule
