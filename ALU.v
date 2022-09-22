module ALU(
    input [7:0]A,
    input [7:0]B,
    input [7:0]T,
    input IMOV,
    input IADD,
    input ISUB,
    input IMUL,
    input IDIV,
    input IOR,
    input INOT,
    input IAND,
    input IXOR,
    input ISHL,
    input ISHR,
    input EALU,
    output [7:0]OUT
);
wire [7:0]S;
assign OUT= EALU?S:8'bz;
mov u_mov(
    .flag(IMOV),
    .B(B),
    .OUT(S)
);
add u_add(
    .flag(IADD),
    .A(A),
    .B(B),
    .OUT(S)
    );
sub u_sub(
    .flag(ISUB),
    .A(A),
    .B(B),
    .OUT(S)
);
cmd_not u_not(
    .flag(INOT),
    .A(A),
    .OUT(S)
);
cmd_and u_and(
    .flag(IAND),
    .A(A),
    .B(B),
    .OUT(S)
);
cmd_or u_or(
    .flag(IOR),
    .A(A),
    .B(B),
    .OUT(S)
);
cmd_xor u_xor(
    .flag(IXOR),
    .A(A),
    .B(B),
    .OUT(S)
);
shl u_shl(
    .flag(ISHL),
    .A(A),
    .B(B),
    .OUT(S)
);
shr u_shr(
    .flag(ISHR),
    .A(A),
    .B(B),
    .OUT(S)
);
mul u_mul(
    .flag(IMUL),
    .T(T),
    .A(A),
    .B(B),
    .OUT(S)
);
div u_div(
    .flag(IDIV),
    .T(T),
    .A(A),
    .B(B),
    .OUT(S)
);
endmodule
module mul (
    input flag,
    input [7:0]T,
    input [7:0]A,
    input [7:0]B,
    output [7:0]OUT
);
reg [7:0]S=0;
reg [15:0]save=0 ;
assign OUT=flag?S:8'bz;
    always @(T) begin
        save[15:0]=A*B;
        if(T[6])S=save[7:0];
        //else if(T[7])S=save[15:8];
        else S=save[15:8];
    end
endmodule
module div (input flag,
             input [7:0]T,
             input [7:0]A,
             input [7:0]B,
             output [7:0]OUT);
    reg [7:0]saveAX = 0,saveDX = 0,S = 0;
    reg [15:0]save;
    assign OUT = flag?S:8'bz;
    wire [7:0]inA,inB;
    always @(T[6]) begin
        if (T[6] == 1'b1)S = saveAX;
        else S = saveDX;
    end
    always @(posedge T[5]) begin
        saveAX = save[15:0]/B[7:0];
        saveDX = save[15:0]%B[7:0];
    end
    always @(negedge T[3]) begin
            save[7:0]  = A[7:0];
            save[15:8] = B[7:0];
    end
endmodule

module mov (
    input flag,
    input [7:0]B,
    output [7:0]OUT
);
    assign OUT=flag?B:8'bz;

endmodule
module cmd_not (
    input flag,
    input [7:0]A,
    output [7:0]OUT
);
    reg [7:0] S=0;
    assign OUT=flag?S:8'bz;
    always @(*) begin
        S = ~ A ;
    end
endmodule
module cmd_or (
    input flag,
    input [7:0]A,
    input [7:0]B,
    output [7:0]OUT
);
    reg [7:0] S=0;
    assign OUT=flag?S:8'bz;
    always @(*) begin
        S = A | B ;
    end
endmodule
module cmd_and (
    input flag,
    input [7:0]A,
    input [7:0]B,
    output [7:0]OUT
);
    reg [7:0] S=0;
    assign OUT=flag?S:8'bz;
    always @(*) begin
        S = A & B ;
    end
endmodule
module cmd_xor (
    input flag,
    input [7:0]A,
    input [7:0]B,
    output [7:0]OUT
);
    reg [7:0] S=0;
    assign OUT=flag?S:8'bz;
    always @(*) begin
        S = A ^ B ;
    end
endmodule
module shl (
    input flag,
    input [7:0]A,
    input [7:0]B,
    output [7:0]OUT
);
    reg [7:0] S=0;
    assign OUT=flag?S:8'bz;
    always @(*) begin
        S = A << B;
    end
endmodule
module shr (
    input flag,
    input [7:0]A,
    input [7:0]B,
    output [7:0]OUT
);
    reg [7:0] S=0;
    assign OUT=flag?S:8'bz;
    always @(*) begin
        S = A >> B;
    end
endmodule
module sub (
    input flag,
    input [7:0]A,
    input [7:0]B,
    output [7:0]OUT
);
    reg [7:0] S=0;
    assign OUT=flag?S:8'bz;
    always @(*) begin
        S = A - B;
    end
endmodule
module add(
input wire flag,
input wire [7:0] A, //输入加数
input wire [7:0] B, //输入加数
output [7:0]OUT //和输出
    );
wire c1;
wire [7:0] S;
assign OUT=flag?S:8'bz;
adder_74LS283 p0(
.Cin(1'b0), //低位进位输入
.A(A[3:0]), //输入加数
.B(B[3:0]), //输入加数
.control(1'b0),//低有效控制端
.S(S[3:0]), //和输出
.Cout(c1) //进位输出
);
adder_74LS283 p1(
.Cin(c1), //低位进位输入
.A(A[7:4]), //输入加数
.B(B[7:4]), //输入加数
.control(1'b0),//低有效控制端
.S(S[7:4]), //和输出
.Cout() //进位输出
);
endmodule
module adder_74LS283(
input wire Cin, //低位进位输入
input wire [3:0] A, //输入加数
input wire [3:0] B, //输入加数
input wire control,//低有效控制端
output wire [3:0] S, //和输出
output wire Cout //进位输出
);
//线网类型
wire P0,P1,P2,P3;
wire G0,G1,G2,G3;
wire C1,C2,C3,C4,check;
//功能定义
assign check = ~control;
assign G0 = A[0] & B[0];
assign G1 = A[1] & B[1];
assign G2 = A[2] & B[2];
assign G3 = A[3] & B[3];
assign P0 = A[0] | B[0];
assign P1 = A[1] | B[1];
assign P2 = A[2] | B[2];
assign P3 = A[3] | B[3];
assign S[0] = ( Cin ^ A[0] ^ B[0] )&check;
assign S[1] = (C1 ^ A[1] ^ B[1] )&check;
assign S[2] = (C2 ^ A[2] ^ B[2] )&check;
assign S[3] = (C3 ^ A[3] ^ B[3] )&check;
assign C1 = ( Cin & P0) | G0;
assign C2 = G1 | (G0 & P1) | ( Cin & P0 & P1);
assign C3 = G2 | (G1&P2) | (G0&P1&P2) | ( Cin&P0&P1&P2);
assign C4 = G3 | (G2&P3) | (G1&P2&P3) | (G0&P1&P2&P3)
| ( Cin&P0&P1&P2&P3);
assign Cout =C4 & check;
endmodule