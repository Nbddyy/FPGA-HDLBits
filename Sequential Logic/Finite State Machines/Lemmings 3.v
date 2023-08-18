module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 

    /*使用二段式解决该问题*/
    reg [3:0] state;
    reg [3:0] state_latch;
    
    parameter LEFT = 4'b0001;
    parameter RIGHT = 4'b0010;
    parameter FALL = 4'b0100;
    parameter DIG = 4'b1000;
    
    /*state transition logic*/
    always@(posedge clk or posedge areset) begin
        if(areset) begin
            state <= LEFT;
            state_latch <= LEFT;
        end else begin
            case(state) 
                LEFT : begin
                    if(!ground) begin
                    	state <= FALL;
                        state_latch <= state;
                    end else if(dig) begin
                        state <= DIG;
                        state_latch <= state;
                    end else if(bump_left) begin
                    	state <= RIGHT; 
                    end else begin
                        state <= LEFT;
                        state_latch <= state_latch;
                    end
                end
                
                RIGHT : begin
               		if(!ground) begin
                    	state <= FALL;
                        state_latch <= state;
                    end else if(dig) begin
                        state <= DIG;
                        state_latch <= state;
                    end else if(bump_right) begin
                    	state <= LEFT; 
                    end else begin
                        state <= RIGHT;
                        state_latch <= state_latch;
                    end
                end
                
                DIG : begin
                    if(!ground) begin
                    	state <= FALL; 
                    end else begin
                       	state <= DIG; 
                    end
                end
                
                FALL : begin
                    if(ground) begin
                        state <= state_latch;
                    end else begin
                    	state <= FALL; 
                    end
                end
                
                default : state <= LEFT;
                
        	endcase
        end 
    end
    
    /*output walk_left*/
    always@(*) begin
        if(areset) begin
            walk_left = 1'd1; 
        end else begin
            walk_left = (state == LEFT) ? 1'd1 : 1'd0; 
        end
    end
    
    /*output walk_right*/
    always@(*) begin
        if(areset) begin
            walk_right = 1'd0; 
        end else begin
            walk_right = (state == RIGHT) ? 1'd1 : 1'd0; 
        end
    end
    
    /*output aaah*/
    always@(*) begin
        if(areset) begin
            aaah = 1'd0; 
        end else begin
            aaah = (state == FALL) ? 1'd1 : 1'd0; 
        end
    end
    
    /*output digging*/
    always@(*) begin
        if(areset) begin
            digging = 1'd0; 
        end else begin
            digging = (state == DIG) ? 1'd1 : 1'd0; 
        end
    end
    
endmodule
