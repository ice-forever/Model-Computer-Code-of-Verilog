//16位2进制数转换为5个BCD码（20位二进制）
`timescale 1ns / 1ps
module bin_16toBCD_5(
    input [15:0] B,
    output reg [19:0] bcdout );
reg [35:0] z;
integer i;
always @( * ) begin
    for(i = 0; i <= 35; i = i+1)
             z[i] = 0;
  z[18:3] = B; // 左移 B 3位
    repeat(13)  begin
    if(z[19:16] > 4)
    z[19:16] = z[19:16] + 3;
    if(z[23:20] > 4)
    z[23:20] = z[23:20] + 3;
    if(z[27:24] > 4)
    z[27:24] = z[27:24] + 3;
    if(z[31:28] > 4)
    z[31:28] = z[31:28] + 3;
    if(z[35:32] > 4)
    z[35:32] = z[35:32] + 3;
    z[35:1] = z[34:0];
    end
    bcdout = z[35:16];//5个 BCD
end
endmodule