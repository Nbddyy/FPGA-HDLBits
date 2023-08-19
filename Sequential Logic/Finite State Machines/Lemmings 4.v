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

    /*define five states*/
    reg [4:0] state;
    reg [4:0] state_latch;
    
    reg [7:0] fall_cnt;	//用于记录lemming-fall的时间
    
    parameter IDLE = 5'b00001;
    parameter LEFT = 5'b00010;
    parameter RIGHT = 5'b00100;
    parameter DIG = 5'b01000;
    parameter FALL = 5'b10000;
    
    /*state transition logic*/
    always@(posedge clk or posedge areset) begin
        if(areset) begin
            state <= LEFT; 
            state_latch <= LEFT;
            fall_cnt <= 8'd0;
        end else begin
            case(state)
                IDLE : begin
                    state <= (areset) ? LEFT : IDLE;
                    fall_cnt <= 8'd0;
                end
                    
                LEFT : begin
                    if(!ground) begin
                    	state <= FALL;
                        state_latch <= LEFT;
                        fall_cnt <= fall_cnt + 8'd1;
                    end else if(dig) begin
                        state <= DIG;
                        state_latch <= LEFT;
                        fall_cnt <= 8'd0;
                    end else if(bump_left) begin
                        state <= RIGHT;
                        state_latch <= RIGHT;
                        fall_cnt <= 8'd0;
                    end else begin
                        state <= state;
                        state_latch <= state_latch;
                        fall_cnt <= 8'd0;
                    end
                end
                
                RIGHT : begin
                    if(!ground) begin
                    	state <= FALL;
                        state_latch <= RIGHT;
                        fall_cnt <= fall_cnt + 8'd1;
                    end else if(dig) begin
                        state <= DIG;
                        state_latch <= RIGHT;
                        fall_cnt <= 8'd0;
                    end else if(bump_right) begin
                        state <= LEFT;
                        state_latch <= LEFT;
                        fall_cnt <= 8'd0;
                    end else begin
                        state <= state;
                        state_latch <= state_latch;
                        fall_cnt <= 8'd0;
                    end
                end
                
                FALL : begin
                    if(ground && fall_cnt <= 8'd20) begin
                        state <= state_latch;
                    end else if(ground) begin
                        state <= IDLE;
                    end else begin
                        state <= FALL;
                        fall_cnt <= fall_cnt + 8'd1;
                    end
                end
                
                DIG : begin
                    if(!ground) begin
                        state <= FALL;
                        fall_cnt <= fall_cnt + 8'd1;
                    end else begin
                       state <= DIG; 
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
