module top_module (
    input clk,
    input reset,
    input [3:1] s,	//3个传感器的low-high情况:s[1] -> S1;s[2] -> S2;s[3] -> S3
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    
    //有几种water Level就有几种状态
	parameter LS1 = 4'b0001;
    parameter HS1 = 4'b0010;
    parameter HS2 = 4'b0100;
    parameter HS3 = 4'b1000;
    
    reg [3:0] state,next_state;
    
    reg continue_flag;	//用于标识初次判断state > next_state后保持不变的条件
    
    always@(posedge clk) begin
        if(reset) begin
           state <= LS1; 
        end else begin
           state <= next_state; 
        end
    end
    
    always@(*) begin
        case(s)
            3'b000 : next_state = LS1;
            3'b001 : next_state = HS1;
            3'b011 : next_state = HS2;
            3'b111 : next_state = HS3;
            default : next_state = LS1;
        endcase
    end
                
    /*输出fr3的代码实现*/
    always@(posedge clk) begin
        if(reset) begin
            fr3 <= 1'd1;
        end else begin
            fr3 <= (next_state == LS1) ? 1'd1 : 1'd0;
        end
    end
    
    /*输出fr2的代码实现*/
    always@(posedge clk) begin
        if(reset) begin
            fr2 <= 1'd1;
        end else begin
            fr2 <= (next_state == LS1 || next_state == HS1) ? 1'd1 : 1'd0;
        end
    end
    
    /*输出fr1的代码实现*/
    always@(posedge clk) begin
        if(reset) begin
            fr1 <= 1'd1;
        end else begin
            fr1 <= (next_state != HS3) ? 1'd1 : 1'd0;
        end
    end
    
    /*输出dfr的代码实现*/
    always@(posedge clk) begin
        if(reset) begin
            dfr <= 1'd1;
            continue_flag <= 1'd0;
        end else if(state > next_state || (state == next_state && continue_flag)) begin
        	dfr <= 1'd1;
            continue_flag <= 1'd1;
        end else begin
            dfr <= 1'd0;
            continue_flag <= 1'd0;
        end
    end

endmodule
