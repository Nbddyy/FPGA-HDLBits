module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right); //  

    // parameter LEFT=0, RIGHT=1, ...
    reg [1:0] state, next_state;

    //define two states;
   	parameter LEFT = 2'b01;
    parameter RIGHT = 2'b10;
    
    always @(*) begin
        // State transition logic
        case(state) 
            LEFT : 
                //next_state = (bump_right && !bump_left) ? RIGHT : RIGHT;		//it's have a mistake,the walk changed by the high signal
                begin
                    if(bump_left) begin
                        next_state = RIGHT;
                    end else begin
                        next_state = state;		//if bump_right is high,state don't change,it will continue the current state.
                    end
                end
            
            RIGHT : begin
                if(bump_right) begin
                    next_state = LEFT;
                end else begin
                    next_state = state; 
                end
            end 
            
            default : next_state = LEFT;
        endcase
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if(areset) begin
        	state <= LEFT; 
        end else begin
            state <= next_state; 
        end
    end

    // Output logic
    assign walk_left = (state == LEFT) ? 1'd1 : 1'd0;
    assign walk_right = (state == RIGHT) ? 1'd1 : 1'd0;

endmodule
