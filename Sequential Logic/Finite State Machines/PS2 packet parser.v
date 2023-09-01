module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done); 	//

    reg [3:0] state;
    reg [3:0] next_state;
    
    parameter BYTE1 = 4'b0001;
    parameter BYTE2 =4'b0010;
    parameter BYTE3 = 4'b0100;
    parameter DONE = 4'b1000;
    
    // State transition logic (combinational)
    always@(*) begin
        if(reset) begin
        	next_state <= BYTE1;
        end else begin
            case(state) 
                BYTE1 : next_state <= (in[3]) ? BYTE2 : BYTE1;
                BYTE2 : next_state <= BYTE3;
                BYTE3 : next_state <= DONE;
                DONE : next_state <= (in[3]) ? BYTE2 : BYTE1;
                default : next_state <= BYTE1;
            endcase
        end
    end
    
    // State flip-flops (sequential)
    always@(posedge clk) begin
        if(reset) begin
           state <= BYTE1;
        end else begin
           state <= next_state; 
        end
    end
    
    // Output logic
    always@(posedge clk) begin
        if(reset) begin
            done = 1'd0; 
        end else begin
            done = (state == BYTE3) ? 1'd1 : 1'd0; 
        end
    end

endmodule
