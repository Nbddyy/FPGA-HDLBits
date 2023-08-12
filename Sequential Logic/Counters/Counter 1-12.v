module top_module (
    input clk,
    input reset,
    input enable,
    output [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d
); //

    assign c_enable = (reset) ? 1'd0 : enable;
    
    always@(*) begin
        if(reset) begin
            c_load = 1'd1; 
            c_d = 1'd1;
        end else if(Q == 4'd12 && c_enable) begin
            c_load = 1'd1; 
            c_d = 1'd1;
        end else begin
            c_load = 1'd0;
            c_d = 1'd0;
        end
    end
    
    count4 the_counter (.clk(clk), .enable(c_enable), .load(c_load), .d(c_d),.Q(Q) /*, ... */ );

endmodule
