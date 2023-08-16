module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q
); 
    /*逻辑表达式处理问题
    Left   : A
    Center : B
    Right  : C
    Y = ABC' + AB'C + A'BC + A'BC' + A'B'C
      = A'B + (B^C)*/
    
    /*center's next state不仅与输入有关，也与当前状态有关，类似于Mearly*/
	genvar i;
    generate for(i = 0; i < 512; i = i + 1) begin : generate_for_512_rule110
        always@(posedge clk) begin
            if(load) begin
                q[i] <= data[i];
            end else begin
                if(i == 0 || i == 511) begin
                    case(i) 
                        0 : q[0] <= (!q[i+1] && q[i]) || (q[i] ^ 0);
                        511 : q[511] <= (!0 && q[i]) || (q[i] ^ q[i-1]);
                        default : q[i] <= 1'b0;
                    endcase
                end else begin
                    q[i] <= (!q[i+1] && q[i]) || (q[i] ^ q[i-1]); 
                end
            end
        end    
    end endgenerate
    
endmodule
