module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 32'h1
    output [31:0] q
); 

    /*可以使用generate来处理重复相同的代码块*/
    genvar i;
    generate for(i = 0; i < 32; i = i + 1) begin : generate_for_32_lfsr
        always@(posedge clk) begin
            if(reset) begin
                if(i == 0) begin
                    q[0] <= 1'h1;
                end else begin
                    q[i] <= 1'h0; 
                end
            end else if(i == 31) begin
                q[31] <= 0 ^ q[0];
            end else if(i == 0 || i == 1 || i == 21) begin
                q[i] <= q[0] ^ q[i + 1];
            end else begin
                q[i] <= q[i + 1];
            end
        end
    end endgenerate
    
endmodule
