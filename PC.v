module PC(input clk,           //��Чʱ��
          input CLEARn,        //��������, ����??????????
          input RUN,           //���п���, ����??????????
          output reg [7:0] B);
    //���ܶ���
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
