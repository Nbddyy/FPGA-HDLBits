# FPGA-HDLBits
The Exercise On HDLBits

中科学习期间找的训练题
网站HDLBits：https://hdlbits.01xz.net/wiki/Main_Page
由于中途产生了托管代码的想法，所以该仓库从章节Sequential Logic的题目Latches and Flip-Flops开始，后续如果有复习需求会将前面题目代码补充上。
如果大家在某个题目上有更好的解题思路，欢迎在Issues中与大家分享。

## 复位:notebook:

```verilog
always@(posedge clk) begin					//rst为同步复位，高电平有效
    if(rst) begin			//synchronous rst
       Execute the statement; 
    end
end

always@(posedge clk or negedge rst_n) begin	//rst_n为异步复位，低电平有效
    if(!rst_n) begin		//asynchronous rst_n
       Execute the statement; 
    end
end
    
always@(posedge clk) begin					//reset为同步复位，高电平有效
    if(reset) begin			//synchronous reset
        Execute the statement; 
    end
end

always@(posedge clk,posedge areset) begin	//reset为异步复位，高电平有效
    if(areset) begin		//asynchronous areset
        Execute the statement; 
    end
end
```

