module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 

    reg [2:0] state;
    reg [2:0] state_latch;	//it will latch the last state before the falling
    
    /*this question has three states*/
    parameter IDLE = 3'b001;
    parameter LEFT = 3'b010;
    parameter RIGHT = 3'b100;
    
    /*状态转移的代码体现*/
    always@(posedge clk or posedge areset) begin
        if(areset) begin
        	state <= LEFT;
            state_latch <= LEFT;
        end else begin
            case(state)
                LEFT : begin
                    if(!ground) begin
                    	state <= IDLE; 
                        state_latch <= state;
                    end else if(bump_left) begin
                       	state <= RIGHT; 
                        state_latch <= state_latch;
                    end else begin
                       	state <= state;
                        state_latch <= state_latch;
                    end
                end
                
                RIGHT : begin
                    if(!ground) begin
                    	state <= IDLE;
                        state_latch <= state;
                    end else if(bump_right) begin
                        state <= LEFT; 
                        state_latch <= state_latch;
                    end else begin
                        state <= state; 
                        state_latch <= state_latch;
                    end
                end
                
                IDLE : begin
                    if(!ground) begin
                    	state <= IDLE; 
                    end else begin
                        state <= state_latch; 
                    end
                end
                
                default : state <= LEFT;
                
            endcase
        end
    end
    
    /*output walk_left*/
    always@(*) begin
        if(areset) begin
        	walk_left <= 1'd1;
        end else begin
        	walk_left <= (state == LEFT) ? 1'd1 : 1'd0; 
        end
    end
    
    /*output walk_right*/
    always@(*) begin
        if(areset) begin
        	walk_right <= 1'd0;
        end else begin
            walk_right <= (state == RIGHT) ? 1'd1 : 1'd0; 
        end
    end
    
    /*output aaah*/
    always@(*) begin
        aaah <= (state == IDLE) ? 1'd1 : 1'd0; 
    end
    
endmodule
