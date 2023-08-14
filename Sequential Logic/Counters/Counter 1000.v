module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
); //

    
    //定义每个计数器的输出
    reg [3:0] q_unit;
    reg [3:0] q_ten;
    reg [3:0] q_hund;
    
    /*0-999的计数*/
    reg [9:0] cnt_1000;
    always@(posedge clk) begin
        if(reset) begin
            cnt_1000 <= 10'd1;
        end else if(cnt_1000 == 10'd999) begin
            cnt_1000 <= 10'd0; 
        end else begin
            cnt_1000 <= cnt_1000 + 10'd1; 
        end
    end
    
    //c_enable[0]用于个位计数
    always@(posedge clk) begin
    	c_enable[0] <= 1'd1;  
    end
    
    bcdcount counter0 (
        .clk(clk), 
        .reset(reset), 
        .enable(c_enable[0]),
        .Q(q_unit)
        /*, ... */);
    
    //c_enable[1]用于十位计数
    always@(posedge clk) begin     
        c_enable[1] <= (cnt_1000 % 10 == 10'd9) ? 1'd1 : 1'd0;
    end
    
    bcdcount counter1 (
        .clk(clk), 
        .reset(reset), 
        .enable(c_enable[1]),
        .Q(q_ten)
        /*, ... */);
    
    //c_enable[2]用于百位计数
    always@(posedge clk) begin
    	c_enable[2] <= ((cnt_1000 - (cnt_1000 / 100) * 100) == 10'd99) ? 1'd1 : 1'd0; 
    end
    
    bcdcount counter2 (
        .clk(clk), 
        .reset(reset), 
        .enable(c_enable[2]),
        .Q(q_hund)
        /*, ... */);

    /*输出OneHertz的代码体现*/
    always@(posedge clk) begin
        if(reset) begin
            OneHertz <=  1'd0;
        end else if(q_hund == 4'd9 && q_ten == 4'd9 && q_unit == 4'd8) begin	//0-999:即检测到998时拉高OneHertz信号
            OneHertz <= 1'd1;	//count once per second,
        end else begin
            OneHertz <=  1'd0;
        end
    end
    
endmodule
