module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 5'h1
    output [4:0] q
); 

    /*输出q[4]的代码实现*/
    always@(posedge clk) begin
        if(reset) begin
            q[4] <= 1'h0; 
        end else begin
            q[4] <= 1'b0 ^ q[0]; 
        end
    end
    
    /*输出q[3]的代码实现*/
    always@(posedge clk) begin
        if(reset) begin
            q[3] <= 1'h0; 
        end else begin
            q[3] <= q[4]; 
        end
    end
    
    /*输出q[2]的代码实现*/
    always@(posedge clk) begin
        if(reset) begin
            q[2] <= 1'h0; 
        end else begin
            q[2] <= q[3] ^ q[0];
        end
    end
    
    /*输出q[1]的代码实现*/
    always@(posedge clk) begin
        if(reset) begin
            q[1] <= 1'h0; 
        end else begin
            q[1] <= q[2]; 
        end
    end
    
    /*输出q[0]的代码实现*/
    always@(posedge clk) begin
        if(reset) begin
            q[0] <= 1'h1; 
        end else begin
            q[0] <= q[1]; 
        end
    end
    
endmodule
