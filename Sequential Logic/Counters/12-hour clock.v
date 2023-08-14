module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss);
    
    /*输出ss的代码实现*/
    always@(posedge clk)begin
        if(reset) begin
    	    ss <= 8'h00;        
        end else if(ena && ss == 8'h59) begin
        	ss <= 8'h00;    
        end else if(ena && ss[3:0] == 4'h9) begin
        	ss <= ss + 8'h07;	//由于十六进制9->10、19->20、29->30递增不能按加1处理，所以需要单独判断作加7处理
        end else if(ena) begin
        	ss <= ss + 8'h01; 
        end else begin
           	ss <= ss; 
        end
    end
    
    /*输出mm的代码实现*/
    always@(posedge clk) begin
        if(reset) begin
            mm <= 8'h00; 
        end else if(ena && mm == 8'h59 && ss == 8'h59) begin	//置0的另一种条件
            mm <= 8'h00;
        end else if(ena && ss == 8'h59 && mm[3:0] == 4'h9) begin
            mm <= mm + 8'h07;    
        end else if(ena && ss == 8'h59) begin
            mm <= mm + 8'h01; 
        end else begin
            mm <= mm; 
        end
    end
    
    /*输出hh的代码体现*/
    always@(posedge clk) begin
        if(reset) begin
            hh <= 8'h12; 
        end else if(ena && hh == 8'h12 && mm == 8'h59 && ss == 8'h59) begin
            hh <= 8'h01; 
        end else if(ena && mm == 8'h59 && ss == 8'h59 && hh[3:0] == 4'h9) begin
            hh <= hh + 8'h07;    
        end else if(ena && mm == 8'h59 && ss == 8'h59) begin
            hh <= hh + 8'h01; 
        end else begin
            hh <= hh; 
        end
    end
    
    /*输出pm的代码实现*/
    always@(posedge clk) begin
        if(reset) begin
            pm <= 1'd0;
        end else if(ena && hh == 8'h11 && mm == 8'h59 && ss == 8'h59) begin
            pm <= ~pm; 
        end else begin
            pm <= pm; 
        end
    end

endmodule
