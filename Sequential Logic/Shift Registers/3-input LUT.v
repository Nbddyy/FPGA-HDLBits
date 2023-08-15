module top_module (
    input clk,
    input enable,
    input S,
    input A, B, C,
    output Z ); 

    reg Q [7:0];
    
    genvar i;
    generate for(i = 0; i < 8; i = i + 1) begin : generate_for_8_dff
        always@(posedge clk) begin
            if(i == 0 && enable) begin
                Q[0] <= S;
            end else if(enable && i != 0) begin
                Q[i] <= Q[i - 1]; 
            end else begin
                Q[i] <= Q[i]; 
            end
        end
    end endgenerate
    
    assign Z = Q[{A,B,C}];

    
endmodule
