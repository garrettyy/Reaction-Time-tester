`timescale 1ns / 1ps

module seven_segment_digit (
    input logic [3:0] digit,
    output logic [6:0] display_bits // Active low
);



always_comb begin

    display_bits = 7'b1111111;
    
    case (digit)
        4'd0: begin
            display_bits = 7'b1000000;
        end
        4'd1: begin
            display_bits = 7'b1111001;
        end
        4'd2: begin
            display_bits = 7'b0100100;
        end
        4'd3: begin
            display_bits = 7'b0110000;
        end
        4'd4: begin
            display_bits = 7'b0011001;
        end
        4'd5: begin
            display_bits = 7'b0010010;
        end
        4'd6: begin
            display_bits = 7'b0000010;
        end
        4'd7: begin
            display_bits = 7'b1111000;
        end
        4'd8: begin
            display_bits = 7'b0000000;
        end
        4'd9: begin
            display_bits = 7'b0011000;
        end
        default: begin
            display_bits = 7'b1111111;
        end
    endcase
end

endmodule