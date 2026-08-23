`timescale 1ns / 1ps

module binary_to_ssd (
    input logic [$clog2(10000)-1:0] binary_in, // up to 9999
    output logic [6:0] display_out [3:0] // 4 arrays of 7 bits
);


logic [3:0] thousands, hundreds, tens, ones;

always_comb begin
    thousands = (binary_in / 1000) % 10;
    hundreds = (binary_in / 100) % 10;
    tens = (binary_in / 10) % 10;
    ones = binary_in % 10;
end

seven_segment_digit inst_thousands(.digit(thousands), .display_bits(display_out[3]));
seven_segment_digit inst_hundreds(.digit(hundreds), .display_bits(display_out[2]));
seven_segment_digit inst_tens(.digit(tens), .display_bits(display_out[1]));
seven_segment_digit inst_ones(.digit(ones), .display_bits(display_out[0]));

endmodule
