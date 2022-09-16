module PC(input clk,           //有效时钟
          input CLEARn,        //清零输入, 低有??????????
          input RUN,           //运行控制, 高有??????????
          output reg [7:0] B);
    //功能定义
    initial begin
        B = 0;
    end
    always @(posedge clk or negedge CLEARn) begin
        if (~CLEARn) begin
            B = 8'd0;
        end
        else begin
            if (RUN)B = B + 1;
        end
    end
endmodule
