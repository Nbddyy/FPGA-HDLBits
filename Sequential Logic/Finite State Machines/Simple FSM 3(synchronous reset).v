module top_module(
    input clk,
    input in,
    input reset,
    output out); //

    reg [3:0] state,next_state;
    
    //使用独热码定义4种状态
    parameter A = 4'b0001;
    parameter B = 4'b0010;
    parameter C = 4'b0100;
    parameter D = 4'b1000;
    
    // State transition logic
    always@(*) begin
        case(state)    
            A : next_state = (in) ? B : A;
            B : next_state = (in) ? B : C;
            C : next_state = (in) ? D : A;
            D : next_state = (in) ? B : C;
            default : next_state = D;
        endcase
    end
    
    // State flip-flops with synchronous reset
    always@(posedge clk) begin
        if(reset) begin
           state <= A; 
        end else begin
           state <= next_state; 
        end
    end
    
    // Output logic
    always@(posedge clk) begin
        if(reset) begin
            out <= 1'd0;
        end else begin
            out <= (next_state == D) ? 1'd1 : 1'd0;  
        end
    end
    
endmodule
