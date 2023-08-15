module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);
    
    reg Q_temp [3:0];	//分别代表对应的DFF的输出Q
    
    genvar i;
    generate for(i = 0; i < 4; i = i + 1) begin : generate_for_4_dff
        always@(posedge clk) begin
            if(~resetn) begin	//this have a mistake,the resetn should be asynchronous reset
                Q_temp[i] <= 1'd0;
            end else if(i == 0) begin
                Q_temp[0] <= in;  
            end else begin
                Q_temp[i] <= Q_temp[i - 1];  
            end
        end
    end endgenerate
    
    assign out = Q_temp[3];

endmodule
