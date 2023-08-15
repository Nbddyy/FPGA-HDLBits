module top_module (
    input clk,
    input w, R, E, L,
    output reg Q
);

    always@(posedge clk) begin
        Q <=  (L == 1'd1) ? R : (E == 1'd1) ? w : Q;
    end
    
endmodule
