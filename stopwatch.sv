`timescale 1ns / 1ps


module stopwatch #(parameter DIVISOR = 100000) (
	input logic clk,
	input logic rst,
	input logic start_watch,
	output logic [$clog2(10000)-1:0] elapsed_time
);

logic tick;
pulse_divider #(.DIVISOR(DIVISOR)) divider_instance (.clk_in(clk), .rst(rst), .clk_out(tick));

always_ff @(posedge clk or posedge rst) begin
	if (rst) begin
		elapsed_time <= '0;
	end 
	else begin
		if (start_watch & tick)
			if (elapsed_time < 14'd9999)
				elapsed_time <= elapsed_time + 1;
	end
end

endmodule
