module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);

    /*个位数字的代码体现*/
    always@(posedge clk) begin
        if(reset) begin
            q[3:0] <= 4'd0;
            ena[1] <= 1'd0;
        end else if(q[3:0] == 4'd8) begin
            q[3:0] <= q[3:0] + 4'd1;
            ena[1] <= 1'd1;	//十位数字递增的触发信号
        end else if(q[3:0] == 4'd9) begin
            q[3:0] <= 4'd0;
            ena[1] <= 1'd0;
        end else begin
            q[3:0] <= q[3:0] + 4'd1;
            ena[1] <= 1'd0;
        end
    end
    
    /*十位数字的代码体现*/
    always@(posedge clk) begin
        if(reset) begin
            q[7:4] <= 4'd0;
            ena[2] <= 1'd0;
        end else if(q[7:4] == 4'd9 && ena[1]) begin	//q对应的四位置0
            q[7:4] <= 4'd0;
            ena[2] <= 1'd0;
        end else if(q[7:4] == 4'd9 && q[3:0] == 4'd8) begin	//千位信号的控制
            q[7:4] <= q[7:4];
            ena[2] <= 1'd1;
        end else if(ena[1]) begin	//十位数字递增的条件
            q[7:4] <= q[7:4] + 4'd1;
            ena[2] <= 1'd0;
        end else begin	//十位数字保持不变
            q[7:4] <= q[7:4];
            ena[2] <= 1'd0;
        end
    end
    
    /*千位数字的代码体现*/
    always@(posedge clk) begin
        if(reset) begin
            q[11:8] <= 4'd0;
            ena[3] <= 1'd0;
        end else if(q[11:8] == 4'd9 && ena[2] && ena[1]) begin	//q对应的四位置0
            q[11:8] <= 4'd0;
            ena[3] <= 1'd0;
        end else if(q[11:8] == 4'd9 && q[7:4] == 4'd9 && q[3:0] == 4'd8) begin	//万位信号的控制
            q[11:8] <= q[11:8];
            ena[3] <= 1'd1;
        end else if(ena[2] && ena[1]) begin	//千位数字递增的条件
            q[11:8] <= q[11:8] + 4'd1;
            ena[3] <= 1'd0;
        end else begin	//千位数字保持不变
            q[11:8] <= q[11:8];
            ena[3] <= 1'd0;
        end
    end
    
    /*万位数字的代码体现*/
    always@(posedge clk) begin
        if(reset) begin
            q[15:12] <= 4'd0;
        end else if(q[15:12] == 4'd9 && ena[3] && ena[2] && ena[1]) begin	//q循环计数，重新置0
            q[15:12] <= 4'd0;
        end else if(ena[3] && ena[2] && ena[1]) begin
            q[15:12] <= q[15:12] + 4'd1; 
        end else begin
            q[15:12] <= q[15:12]; 
        end
    end
    
endmodule
