module top_module(
    input clk,
    input areset,    // Asynchronous reset to state B
    input in,
    output out);//  

    parameter A=0, B=1; 
    reg state, next_state;

    always @(*) begin    // This is a combinational always block
        // State transition logic

        case(state) 
            B : begin
                next_state <= (in == 1'd1) ? state : A; 
            end

            A : next_state <= (in == 1'd1) ? state : B;
        endcase

    end

    always @(posedge clk, posedge areset) begin    // This is a sequential always block
        // State flip-flops with asynchronous reset
        if(areset) begin
            state <= B;
        end else begin
           	state <= next_state; 
        end
    end

    // Output logic
    // assign out = (state == ...);
    assign out = (state == A) ? 1'd0 : 1'd1;

endmodule
