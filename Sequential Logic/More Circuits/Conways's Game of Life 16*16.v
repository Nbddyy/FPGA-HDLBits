module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q ); 

    reg [3:0] survive_cnt [255:0];

    genvar i;
    generate for(i = 0; i < 256; i = i + 1) begin : generate_for_256_cells

        always@(posedge clk) begin
            survive_cnt[i] = 4'd0;

            if(load) begin
                q[i] <= data[i]; 
            end else begin
                if(i == 0 || i == 15 || i == 240 || i == 255) begin     //四个角单元的单元格的状态处理
                    case(i) 
                        0 : begin
                            survive_cnt[i] = (q[255]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                            survive_cnt[i] = (q[240]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                            survive_cnt[i] = (q[241]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                            survive_cnt[i] = (q[15]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                            survive_cnt[i] = (q[1]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                            survive_cnt[i] = (q[31]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                            survive_cnt[i] = (q[16]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                            survive_cnt[i] = (q[17]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                        end

                        15 : begin
                            survive_cnt[i] = (q[254]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                            survive_cnt[i] = (q[255]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                            survive_cnt[i] = (q[240]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                            survive_cnt[i] = (q[14]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                            survive_cnt[i] = (q[0]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                            survive_cnt[i] = (q[30]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                            survive_cnt[i] = (q[31]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                            survive_cnt[i] = (q[16]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                        end

                        240 : begin
                            survive_cnt[i] = (q[239]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                            survive_cnt[i] = (q[224]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                            survive_cnt[i] = (q[225]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                            survive_cnt[i] = (q[255]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                            survive_cnt[i] = (q[241]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                            survive_cnt[i] = (q[15]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                            survive_cnt[i] = (q[0]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                            survive_cnt[i] = (q[1]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                        end

                        255 : begin
                            survive_cnt[i] = (q[238]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                            survive_cnt[i] = (q[239]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                            survive_cnt[i] = (q[224]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                            survive_cnt[i] = (q[254]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                            survive_cnt[i] = (q[240]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                            survive_cnt[i] = (q[14]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                            survive_cnt[i] = (q[15]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                            survive_cnt[i] = (q[0]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                        end

                        default : survive_cnt[i] <= 4'd0;

                    endcase

                    if(survive_cnt[i] < 2) begin
                        q[i] <= 1'd0;
                    end else if(survive_cnt[i] < 3) begin
                        q[i] <= q[i];
                    end else if(survive_cnt[i] < 4) begin
                        q[i] <= 1'd1;
                    end else begin
                        q[i] <= 1'd0;
                    end
                end else if(i >= 1 && i <= 14) begin    //位于边上第一行单元格的状态处理
                    survive_cnt[i] = (q[i+239]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                    survive_cnt[i] = (q[i+240]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                    survive_cnt[i] = (q[i+241]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                    survive_cnt[i] = (q[i-1]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                    survive_cnt[i] = (q[i+1]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                    survive_cnt[i] = (q[i+15]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                    survive_cnt[i] = (q[i+16]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                    survive_cnt[i] = (q[i+17]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];

                    if(survive_cnt[i] < 2) begin
                        q[i] <= 1'd0;
                    end else if(survive_cnt[i] < 3) begin
                        q[i] <= q[i];
                    end else if(survive_cnt[i] < 4) begin
                        q[i] <= 1'd1;
                    end else begin
                        q[i] <= 1'd0;
                    end
                end else if(i >= 241 && i <= 254) begin     //位于边上第15行单元格的状态处理
                    survive_cnt[i] = (q[i-17]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                    survive_cnt[i] = (q[i-16]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                    survive_cnt[i] = (q[i-15]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                    survive_cnt[i] = (q[i-1]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                    survive_cnt[i] = (q[i+1]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                    survive_cnt[i] = (q[i-241]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                    survive_cnt[i] = (q[i-240]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                    survive_cnt[i] = (q[i-239]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];

                    if(survive_cnt[i] < 2) begin
                        q[i] <= 1'd0;
                    end else if(survive_cnt[i] < 3) begin
                        q[i] <= q[i];
                    end else if(survive_cnt[i] < 4) begin
                        q[i] <= 1'd1;
                    end else begin
                        q[i] <= 1'd0;
                    end
                end else if(i % 16 == 0) begin     //位于边上第0列单元格的状态处理
                    survive_cnt[i] = (q[i-1]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                    survive_cnt[i] = (q[i-16]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                    survive_cnt[i] = (q[i-15]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                    survive_cnt[i] = (q[i+15]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                    survive_cnt[i] = (q[i+1]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                    survive_cnt[i] = (q[i+31]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                    survive_cnt[i] = (q[i+16]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                    survive_cnt[i] = (q[i+17]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];

                    if(survive_cnt[i] < 2) begin
                        q[i] <= 1'd0;
                    end else if(survive_cnt[i] < 3) begin
                        q[i] <= q[i];
                    end else if(survive_cnt[i] < 4) begin
                        q[i] <= 1'd1;
                    end else begin
                        q[i] <= 1'd0;
                    end
                end else if(i % 16 == 15) begin     //位于边上第15列单元格的状态处理
                    survive_cnt[i] = (q[i-17]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                    survive_cnt[i] = (q[i-16]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                    survive_cnt[i] = (q[i-31]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                    survive_cnt[i] = (q[i-1]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                    survive_cnt[i] = (q[i-15]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                    survive_cnt[i] = (q[i+15]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                    survive_cnt[i] = (q[i+16]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                    survive_cnt[i] = (q[i+1]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];

                    if(survive_cnt[i] < 2) begin
                        q[i] <= 1'd0;
                    end else if(survive_cnt[i] < 3) begin
                        q[i] <= q[i];
                    end else if(survive_cnt[i] < 4) begin
                        q[i] <= 1'd1;
                    end else begin
                        q[i] <= 1'd0;
                    end
                end else begin
                    survive_cnt[i] = (q[i-17]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                    survive_cnt[i] = (q[i-16]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                    survive_cnt[i] = (q[i-15]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                    survive_cnt[i] = (q[i-1]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                    survive_cnt[i] = (q[i+1]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                    survive_cnt[i] = (q[i+15]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                    survive_cnt[i] = (q[i+16]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];
                    survive_cnt[i] = (q[i+17]) ? survive_cnt[i] + 4'd1 : survive_cnt[i];

                    if(survive_cnt[i] < 2) begin
                        q[i] <= 1'd0;
                    end else if(survive_cnt[i] < 3) begin
                        q[i] <= q[i];
                    end else if(survive_cnt[i] < 4) begin
                        q[i] <= 1'd1;
                    end else begin
                        q[i] <= 1'd0;
                    end
                end




            end
        end

    end endgenerate
    
endmodule
