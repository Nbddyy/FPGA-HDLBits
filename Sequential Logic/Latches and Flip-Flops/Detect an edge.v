module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);
    /*使用rise_latch来控制对in信号的一次拉高*/
    reg rise_latch [7:0];
    
    genvar i;
    generate for(i = 0; i < 8; i = i + 1) begin : generate_8_rise_detect
        always@(posedge clk) begin
            if(in[i] && !rise_latch[i]) begin
                pedge[i] <= 1'd1;
                rise_latch[i] <= 1'd1;
            end else if(!in[i]) begin
                pedge[i] <= 1'd0;
                rise_latch[i] <= 1'd0;
            end else begin
                pedge[i] <= 1'd0;
                rise_latch[i] <= 1'd1;
            end
        end
        
    end endgenerate 

endmodule
