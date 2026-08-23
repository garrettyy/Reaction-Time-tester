`timescale 1ns / 1ps

module basys_ssd #(parameter DIVISOR = 100000) (
    input logic clk, // 100MHz system clock
    input logic rst, // Active High reset
    input logic [6:0] ssd_in [3:0], // The four digits to display
    output logic [3:0] an, // Which display to drive
    output logic [6:0] seg // The number to display
);

logic clk_out;
logic [1:0] counter;

clock_divider #(.DIVISOR(DIVISOR)) inst_divider(.clk_in(clk), .rst(rst), .clk_out(clk_out));

always_ff @(posedge clk_out, posedge rst) begin
    if (rst) counter <= '0; 
    else begin
        case (counter)
            2'd0: begin
                an <= 4'b1110;
                seg <= ssd_in[0];
            end
            2'd1: begin
                an <= 4'b1101;
                seg <= ssd_in[1];
            end
            2'd2: begin
                an <= 4'b1011;
                seg <= ssd_in[2];
            end
            2'd3: begin
                an <= 4'b0111;
                seg <= ssd_in[3];
            end
            default: begin
                an <= 4'b1111;
                seg <= 7'b1111111;
            end
        endcase
        counter <= counter + '1;
    end
end
endmodule
