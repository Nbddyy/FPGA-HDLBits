module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);

    /*下降沿检测每一位宽并保持输出，直至复位信号置0*/
    reg in_clap_1 [31:0];	//打一拍，其获得的fall信号没有延拍
    
    //wire in_rise [31:0];
    wire in_fall [31:0];
    
    genvar i;
    generate for(i = 0; i < 32; i = i + 1) begin : generate_32_fall_detect
        always@(posedge clk) begin
            in_clap_1[i] <= in[i];    //通过对波形图的观察发现，该打拍操作不能受reset影响
        end
        
        assign in_fall[i] = in_clap_1[i] && !in[i];
        
    end endgenerate
    
    
    genvar j;
    generate for(j = 0; j < 32; j = j + 1) begin : generate_32_out_result
    	/*输出out的代码实现：下降沿拉高保持，直至复位置0*/
        always@(posedge clk) begin
            if(reset) begin    //此处实现优先级判断，当检测到下降沿时优先复位，后捕获输入信号
                out[j] = 1'd0;
            end else if(in_fall[j]) begin
                out[j] = 1'd1; 
            end else begin
                out[j] = out[j]; 
            end
        end
    end endgenerate
        
endmodule
