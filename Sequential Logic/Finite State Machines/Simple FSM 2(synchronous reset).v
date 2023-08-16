module top_module(
    input clk,
    input reset,    // synchronous reset to OFF
    input j,
    input k,
    output out); //  

    parameter OFF=0, ON=1; 
    reg state, next_state;

    always @(*) begin
        // State transition logic
        case(state)
            OFF : next_state <= (j) ? ON : OFF;
            ON : next_state <= (k) ? OFF : ON;
            default : next_state <= OFF;
        endcase
    end

    /*synchornous reset指的是同步复位，即在clk信号上升沿的时候触发
    asynchronous areset指的是异步复位，即复位由areset信号触发*/
    always @(posedge clk) begin
        // State flip-flops with synchronous reset
        if(reset) begin
           state <= OFF; 
        end else begin
           state <= next_state; 
        end
    end

    // Output logic
    // assign out = (state == ...);
    assign out = (state == OFF) ? 1'd0: 1'd1;
    
endmodule
