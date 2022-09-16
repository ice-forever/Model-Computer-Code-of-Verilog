module ROM (input [7:0]addr,
            output reg [7:0]OUT);
always @(addr) begin
    case (addr)
        0: OUT       = {4'd0,2'd2,2'd0};//MOV DX,15
        1: OUT       = 8'd15;
        2: OUT       = {4'd0,2'd1,2'd0};//MOV AX,6
        3: OUT       = 8'd6;
        4: OUT       = {4'd1,2'd1,2'd0};//ADD AX,7
        5: OUT       = 8'd7;
        6: OUT       = {4'd2,2'd2,2'd1};//SUB DX,AX
        7: OUT       = {4'd4,2'd0,2'd0};//MUL 40
        8: OUT       = 8'd40;
        9: OUT       = {4'd9,2'd2,2'd2};//XOR DX,DX
        10: OUT       = {4'd5,2'd0,2'd0};//DIV 5
        11: OUT       = 8'd5;
        12: OUT       = {4'd6,2'd1,2'd0};//OR AX,10
        13: OUT       = 8'd10;
        14: OUT       = {4'd7,2'd2,2'd0};//NOT DX
        15: OUT       = {4'd8,2'd1,2'd2};//AND AX,DX
        16: OUT      = {4'd11,2'd2,2'd0};//SHR DX,1
        17: OUT       = 8'd1;
        18: OUT      = {4'd10,2'd1,2'd0};//SHL AX,1
        19: OUT       = 8'd1;
        20: OUT      = {4'd0,2'd2,2'd1};//MOV DX,AX
        default: OUT = {4'd3,2'd0,2'd0};//HALT
    endcase
end
endmodule
