// Note the Verilog-1995 module declaration syntax here:
module top_module(clk, reset, in, out);
    input clk;
    input reset;    // Synchronous reset to state B
    input in;
    output reg out;//  

    // Fill in state name declarations
    parameter B = 2'b01;
    parameter A = 2'b10;

    reg [1:0] present_state,next_state;

    /*next_state状态转移的代码实现*/
    always@(*) begin
        case(present_state) 
            A : next_state <= (in) ? A : B;
            B : next_state <= (in) ? B : A;
            default : next_state <= B;
        endcase
    end
    
    /*presnt_state状态赋值的代码实现*/
    always@(posedge clk) begin
        if(reset) begin
           present_state <= B; 
        end else begin
           present_state <= next_state; 
        end
    end
    
    /*输出out的代码实现*/
    always@(posedge clk or posedge reset) begin
        /*the first way
        Moore方式输出：输出仅与当前状态有关*/
        //case(present_state)	//
        //    A : out <= 1'd0;
        //    B : out <= 1'd1;
        //    default : out <= 1'd1;
        //endcase
        
        /*the second way
        Mearly方式输出：输出不仅与当前状态有关，也与输出有关*/
        case(next_state)
            A : out <= (in) ? 1'd0 : 1'd1;
            B : out <= (in) ? 1'd1 : 1'd0;
            default : out <= 1'd0;
        endcase
    end

endmodule
