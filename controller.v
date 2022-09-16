module controller (
    input [7:0]IR,
    input [7:0]T,
    output [1:0]SRC,
    output [1:0]DST,
    output reg [3:0]IRX,
    output IMOV,
    output IADD,
    output ISUB,
    output HALT,
    output IMUL,
    output IDIV,
    output IOR,
    output INOT,
    output IAND,
    output IXOR,
    output ISHL,
    output ISHR,
    output IMAR,//地址寄存器
    output IDR,//数据寄存器
    output EDR,//数据寄存器
    output IPC,//程序计数器
    output IIR,
    output EALU//
    
);
initial IRX=4'd0;
    wire MOV,ADD,SUB,MUL,DIV,OR,NOT,AND,XOR,SHL,SHR,T34run;
    wire [1:0]MUL2,DIV2,special,T32,T22;
    assign MOV=~IR[7]&~IR[6]&~IR[5]&~IR[4];
    assign ADD=~IR[7]&~IR[6]&~IR[5]&IR[4];
    assign SUB=~IR[7]&~IR[6]&IR[5]&~IR[4];
    assign HALT=~IR[7]&~IR[6]&IR[5]&IR[4];
    assign MUL=~IR[7]&IR[6]&~IR[5]&~IR[4];
    assign DIV=~IR[7]&IR[6]&~IR[5]&IR[4];
    assign OR=~IR[7]&IR[6]&IR[5]&~IR[4];
    assign NOT=~IR[7]&IR[6]&IR[5]&IR[4];
    assign AND=IR[7]&~IR[6]&~IR[5]&~IR[4];
    assign XOR=IR[7]&~IR[6]&~IR[5]&IR[4];
    assign SHL=IR[7]&~IR[6]&IR[5]&~IR[4];
    assign SHR=IR[7]&~IR[6]&IR[5]&IR[4];
    assign MUL2={MUL,MUL};
    assign DIV2={DIV,DIV};
    assign T32={T[3],T[3]};
    assign T22={T[2],T[2]};
    assign special=MUL2|DIV2;
    assign DST=(IR[3:2]&~special)|(special&2'b01&~T32)|(DIV2&T32&2'b01);
    assign SRC=(IR[1:0]&~T32)|(DIV2&T32&2'b10)|(DIV2&T22&2'b10);
    assign EALU=IMOV|IADD|ISUB|IMUL|IDIV|IOR|INOT|IAND|IXOR|ISHL|ISHR;
    assign T56=(T[5]|T[6]);
    assign T567=(T[5]|T[6]|T[7]);
    assign T34run=(~(IR[1]|IR[0]))&(~NOT);
    assign IMAR=T[0]|(T34run&T[3]);
    assign IDR=T[1]|(T34run&T[4]);
    assign IPC=T[2]|(T34run&T[5]);
    assign IIR=T[2];
    assign EDR=~T567;
    assign IMOV=T56&MOV;
    assign IADD=T56&ADD;
    assign ISUB=T56&SUB;
    assign IMUL=T567&MUL;
    assign IDIV=T567&DIV;
    assign IOR=T56&OR;
    assign INOT=T56&NOT;
    assign IAND=T56&AND;
    assign IXOR=T56&XOR;
    assign ISHL=T56&SHL;
    assign ISHR=T56&SHR;
    always @(*) begin
        IRX[3:0]=4'b0000;
        IRX[0]=(~SRC[0])&(~SRC[1])&(EDR);
        if(IMUL|IDIV) begin
        IRX[1]=T[6]&(IMUL|IDIV);
        IRX[2]=T[7]&(IMUL|IDIV);
        end
        else begin
        IRX[DST]=T[6]&~T[7]&~(IMUL|IDIV);
        end
        
    end

endmodule