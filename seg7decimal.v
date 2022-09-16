`timescale 1ns / 1ps
module seg7decimal(
	input [31:0] x,
	input clk,
	output reg [6:0] g_to_a,
	output reg [7:0] an,
	output wire dp );
wire [2:0] s;
reg [3:0] digit;
wire [7:0] aen;
reg [19:0] clkdiv;
assign dp = 1;
assign s = clkdiv[19:17];
assign aen = 8'b11111111;
always @( posedge clk ) begin
    case(s)
    0:digit = x[3:0];
    1:digit = x[7:4];
    2:digit = x[11:8];
    3:digit = x[15:12];
    4:digit = x[19:16];
    5:digit = x[23:20];
    6:digit = x[27:24];
    7:digit = x[31:28];
    default:digit = x[3:0];
    endcase
end
//根据g_to_a控制7段的显示
always @(*) begin

    case(digit)
    
    //////////////gfedcba//////////         a
    0:g_to_a = 7'b1000000;////0000        __
    1:g_to_a = 7'b1111001;////0001    f/ g /b
    2:g_to_a = 7'b0100100;////0010     __
    3:g_to_a = 7'b0110000;////0011 e / /c
    4:g_to_a = 7'b0011001;////0100  __
    5:g_to_a = 7'b0010010;////0101   d
    6:g_to_a = 7'b0000010;////0110
    7:g_to_a = 7'b1111000;////0111
    8:g_to_a = 7'b0000000;////1000
    9:g_to_a = 7'b0010000;////1001
    10:g_to_a= 7'b0111111;////-
    default: g_to_a = 7'b1111111; // 全灭
    endcase
end

always @(*) begin
    an=8'b11111111;
    if(aen[s] == 1)
        an[s] = 0;
    else  
    an[s] = 1;
end

//clkdiv 763Hz
always @(posedge clk) begin
    clkdiv <= clkdiv+1;
end
endmodule

