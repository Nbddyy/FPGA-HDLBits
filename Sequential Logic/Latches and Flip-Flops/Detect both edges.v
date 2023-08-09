module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);
    
    /*使用打拍得到输入的边沿信号，由于打拍是对位宽为1的信号操作，
    所以需要使用generate for对输入信号的每个位宽进行打拍操作*/
    
    reg in_clap_1 [7:0];	//对输入的第一次打拍
    reg in_clap_2 [7:0];	//对输入的第二次打拍
    
    wire in_rise [7:0];
    wire in_fall [7:0];
    
    genvar i;
    generate for(i = 0; i < 8; i = i + 1) begin : generate_8_edge_detect
        always@(posedge clk) begin
            in_clap_1[i] <= in[i];
            in_clap_2[i] <= in_clap_1[i];
        end
        
        assign in_rise[i] = in_clap_1[i] && !in_clap_2[i];
        assign in_fall[i] = in_clap_2[i] && !in_clap_1[i];
        
        assign anyedge[i] = in_rise[i] || in_fall[i];
    end endgenerate

endmodule
