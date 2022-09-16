module clock_4hz(input clk,
                 input CLEARn,   //清零输入, 低有??
                 output clk4hz);
    //功能定义
    reg  T1hz;
    reg  [25:0] Q_conut;
    assign clk4hz   = T1hz ;//& RUN;
    initial T1hz    = 0;
    initial Q_conut = 0;
    //always @(posedge clk or negedge CLEARn) begin
    always @(posedge clk or negedge CLEARn) begin
        if (~CLEARn) Q_conut = 26'd0;
        else begin
        if (Q_conut < 26'd12499999)
            Q_conut      = Q_conut + 1;
            else Q_conut = 26'd0;
            end
    end
            //always @ (posedge clk or negedge CLEARn) begin
            always @(posedge clk or negedge CLEARn) begin
                if (~CLEARn) T1hz = 0;
                else begin
                if (Q_conut == 26'd0)
                    T1hz = ~ T1hz;
                    end
            end
endmodule
module clock_divide5(input clk,
                 input CLEARn,   //清零输入, 低有??
                 output clk5);
    //功能定义
    reg  T1hz;
    reg  [3:0] Q_conut;
    assign clk5   = T1hz ;//& RUN;
    initial T1hz    = 0;
    initial Q_conut = 0;
    //always @(posedge clk or negedge CLEARn) begin
    always @(posedge clk or negedge CLEARn) begin
        if (~CLEARn) Q_conut = 4'd0;
        else begin
        if (Q_conut < 4'd4)
            Q_conut      = Q_conut + 1;
            else Q_conut = 4'd0;
            end
    end
            //always @ (posedge clk or negedge CLEARn) begin
            always @(posedge clk or negedge CLEARn) begin
                if (~CLEARn) T1hz = 0;
                else begin
                if (Q_conut == 4'd0)
                    T1hz = ~ T1hz;
                    end
            end
endmodule
