module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); //

    /*使用generat处理重复执行的代码*/
    genvar i;
    generate for(i = 0; i < 4; i = i + 1) begin : generate_for_4_mux_dff
        
        MUXDFF inst_MUXDFF (
            .clk(KEY[0]),
            .w((i == 3) ? KEY[3] : LEDR[i + 1]),
            .q_in(LEDR[i]),
            .e(KEY[1]),
            .r(SW[i]),
            .l(KEY[2]),
            .q_out(LEDR[i])
        );
        
    end endgenerate
    
endmodule

module MUXDFF (
    input clk,
    input w,
    input q_in,
    input e,r,l,
    output q_out
);

    always@(posedge clk) begin
        q_out <= (l == 1'd1) ? r : (e == 1'd1) ? w : q_in;    
    end
    
endmodule
