module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q ); 

    /*center's next state仅仅与左右两个值有关
    常规位置的左右两个为i-1、i、i+1
    边端位置0左右为q[-1]、511
    边端位置511左右为510、q[512]
    这里由题意可知q[-1]和q[512]均为零*/
    
    genvar i;
    generate for(i = 0; i < 512; i = i + 1) begin : generate_for_512_rule90
        always@(posedge clk) begin
            if(load) begin
                q[i] <= data[i];
            end else begin
                if(i == 0 || i == 511) begin
                    case(i) 
                        0 : q[0] <= q[1] ^ 0;
                        511 : q[511] <= q[510] ^ 0;
                        default : q[i] <= 1'b0;
                    endcase
                end else begin
                    q[i] <= q[i-1] ^ q[i+1]; 
                end
            end
        end    
    end endgenerate
    
endmodule
