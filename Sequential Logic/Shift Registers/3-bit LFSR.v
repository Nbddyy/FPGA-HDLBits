module top_module (
	input [2:0] SW,      // R
	input [1:0] KEY,     // L and clk
	output [2:0] LEDR);  // Q

    SubModule SubModule_1 (
        .clk(KEY[0]),
        .l_in(KEY[1]),
        .r_in(SW[0]),
        .q_in(LEDR[2]),
        .Q(LEDR[0])
	);

    SubModule SubModule_2 (
        .clk(KEY[0]),
        .l_in(KEY[1]),
        .r_in(SW[1]),
        .q_in(LEDR[0]),
        .Q(LEDR[1])
	);
    
    SubModule SubModule_3 (
        .clk(KEY[0]),
        .l_in(KEY[1]),
        .r_in(SW[2]),
        .q_in(LEDR[1] ^ LEDR[2]),
        .Q(LEDR[2])
	);
    
endmodule

module SubModule(
	input clk,
    input l_in,
    input r_in,
    input q_in,
    output reg Q
);
    always@(posedge clk) begin
        Q <= (l_in == 1'd1) ? r_in : q_in; 
    end
    
endmodule
