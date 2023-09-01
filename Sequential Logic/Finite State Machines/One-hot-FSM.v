module top_module(
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);

    //三段式状态机
    parameter S0 = 10'b0_000_000_001;
    parameter S1 = 10'b0_000_000_010;
    parameter S2 = 10'b0_000_000_100;
    parameter S3 = 10'b0_000_001_000;
    parameter S4 = 10'b0_000_010_000;
    parameter S5 = 10'b0_000_100_000;
    parameter S6 = 10'b0_001_000_000;
    parameter S7 = 10'b0_010_000_000;
    parameter S8 = 10'b0_100_000_000;
    parameter S9 = 10'b1_000_000_000;
    
    /*next_state transition logic*/
    always@(*) begin
        case(state)
            S0 : next_state = (in) ? S1 : S0;
            S1 : next_state = (in) ? S2 : S0;
            S2 : next_state = (in) ? S3 : S0;
            S3 : next_state = (in) ? S4 : S0;
            S4 : next_state = (in) ? S5 : S0;
            S5 : next_state = (in) ? S6 : S8;
            S6 : next_state = (in) ? S7 : S9;
            S7 : next_state = (!in) ? S0 : S7;
            S8 : next_state = (in) ? S1 : S0;
            S9 : next_state = (in) ? S1 : S0;
            default : next_state = 10'd0;
        endcase
    end
    
    /*output out1*/
    always@(*) begin
        out1 = (state == S8 || state == S9) ? 1'd1 : 1'd0;
    end
    
	/*output out2*/
    always@(*) begin
        out2 = (state == S9 || state == S7) ? 1'd1 : 1'd0;
    end
                
endmodule
