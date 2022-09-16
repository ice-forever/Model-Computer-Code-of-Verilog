module REGclk(input clk,
    input inflag,
           input outflag,
           input [7:0]RIN,
           output [7:0]checkout,
           output reg [7:0]ROUT);
    wire [7:0]checkin;
    assign checkin  = inflag ? RIN : 8'bz;
    assign checkout = outflag ? ROUT : 8'bz;
    initial ROUT=8'b0;
    always @(negedge clk) begin
        if(inflag==1'b1) begin 
            ROUT = checkin;
        end
    end
endmodule
module REG(
    input inflag,
           input outflag,
           input [7:0]RIN,
           output [7:0]checkout,
           output reg [7:0]ROUT);
    wire [7:0]checkin;
    assign checkin  = inflag ? RIN : 8'bz;
    assign checkout = outflag ? ROUT : 8'bz;
    initial ROUT=8'b0;
    always @(*) begin
        if(inflag==1'b1) begin 
            ROUT = checkin;
        end
    end
endmodule