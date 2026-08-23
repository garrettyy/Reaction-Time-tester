`timescale 1ns / 1ps

module reaction_tester_top (
    input logic clk,
    input logic rst,
    input logic button,
    output logic [3:0] an,
    output logic [6:0] seg,
    output logic light
    );
    
logic [$clog2(10000)-1:0] elapsed_time;
logic [6:0] display_bits [3:0];
logic [7:0] random_number;
logic generate_num, start_watch, new_clk, button_last, button_posedge;
logic [7:0] counter;

typedef enum logic [1:0] {
    RESET = 2'd0,
    SET = 2'd1,
    GO = 2'd2,
    SCORE = 2'd3
} state_type;

state_type state, next_state;

always_ff @(posedge clk) begin
    button_last <= button;
end

assign button_posedge = button && !button_last;

always_ff @(posedge clk, posedge rst) begin 
    if (rst)
        state <= RESET;
    else
        state <= next_state;
end

always_ff @(posedge new_clk, posedge rst) begin
    if (rst) begin
        counter <= '0;
    end
    else begin
        if (state == RESET)
            counter <= random_number;
         else if (state == SET && counter > 0)
            counter <= counter - 1;
    end
end

always_comb begin
    next_state = state;
    generate_num = '0;
    start_watch = '0;
    light = '0;
    
    case (state)
        RESET: begin
            generate_num = '1;
            
            if (button_posedge)
                next_state = SET;
        end
        
        SET: begin
            if (counter == '0)
                next_state = GO;
        end
        
        GO: begin
            light = '1;
            start_watch = '1;
            
            if (button_posedge)
                next_state = SCORE;
        end
        
        SCORE: 
            next_state = SCORE;
        
        default: 
            next_state = RESET;
    endcase

end


clock_divider #(.DIVISOR(10000000)) DUT_clock_divider(.clk_in(clk), .rst(rst), .clk_out(new_clk));

random_number_generator DUT_random_number_generator (.clk(clk), .rst(rst), .generate_num(generate_num), .random_number(random_number));

stopwatch #(.DIVISOR(100000)) DUT_stopwatch( .clk(clk), .rst(rst), .start_watch(start_watch), .elapsed_time(elapsed_time));

binary_to_ssd DUT_binary_to_ssd(.binary_in(elapsed_time), .display_out(display_bits));

basys_ssd DUT_basys_ssd(.clk(clk), .rst(rst), .ssd_in(display_bits), .an(an), .seg(seg));


endmodule
