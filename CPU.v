`timescale  1ns / 1ps
module CPU(
    input  RUN,
    input  clk,
    input  RESET,
    output wire  [7:0]AX,
    output wire  [7:0]DX,
    output wire  [7:0]R ,
    output wire  [7:0]  ABUS ,
    output wire  [7:0]  DBUS ,
    output wire  [7:0]  D2BUS ,
    output wire  [7:0] T,
output wire [7:0] ALU_A,
output wire [7:0] ALU_B,
output wire [7:0] PC2MAR,
output wire [7:0] IROUT,
output wire [3:0]IRX,
output wire [1:0]SRC,
output wire [1:0]DST,
output HALT

);


rhythm  u_rhythm (
    .clk                     ( clk           ),
    .CLEARn                  ( ~RESET        ),
    .T                       ( T       [7:0] )
    );
    controller  u_controller (
    .IR                      ( IROUT    [7:0] ),
    .T                       ( T     [7:0] ),
    .SRC                     ( SRC   [1:0] ),
    .DST                     ( DST   [1:0] ),
    .IRX                     ( IRX   [3:0] ),
    .IMOV                    ( IMOV        ),
    .IADD                    ( IADD        ),
    .ISUB                    ( ISUB        ),
    .HALT                    ( HALT        ),
    .IMUL                    ( IMUL        ),
    .IDIV                    ( IDIV        ),
    .IOR                     ( IOR         ),
    .INOT                    ( INOT        ),
    .IAND                    ( IAND        ),
    .IXOR                    ( IXOR        ),
    .ISHL                    ( ISHL        ),
    .ISHR                    ( ISHR        ),
    .IMAR                    ( IMAR        ),
    .IDR                     ( IDR         ),
    .EDR                     ( EDR         ),
    .IPC                     ( IPC         ),
    .IIR                     ( IIR         ),
    .EALU                    ( EALU        )
);
   /*clock_divide5 u_clk(
    .clk(clk100mhz),
    .CLEARn(RUN|~HALT),   //«Â¡„ ‰»Î, µÕ”–??
    .clk5(clk));*/
    PC u_PC (
    .clk (clk),
    .CLEARn (~RESET),
    .RUN (IPC),
    .B (PC2MAR));
    REG u_MAR (
    .inflag(IMAR),
    .outflag(),
    .RIN(PC2MAR),
    .checkout(),
    .ROUT(ABUS));
    ROM  u_ROM (
    .addr(ABUS),
    .OUT(DBUS)
    );
    REG u_DR (.inflag(IDR),
    .outflag(EDR),
    .RIN(DBUS),
    .checkout(D2BUS),
    .ROUT());
    REG u_IR (.inflag(IIR),
    .outflag(),
    .RIN(D2BUS),
    .checkout(),
    .ROUT(IROUT));
    REGclk u_AX (.clk(clk),.inflag(IRX[1]),
    .outflag(),
    .RIN(D2BUS),
    .checkout(),
    .ROUT(AX));
    REGclk u_DX (.clk(clk),.inflag(IRX[2]),
    .outflag(),
    .RIN(D2BUS),
    .checkout(),
    .ROUT(DX));
    REGclk u_CX (.clk(clk),.inflag(IRX[3]),
    .outflag(),
    .RIN(D2BUS),
    .checkout(),
    .ROUT(CX));
    REGclk u_R (.clk(clk),.inflag(IRX[0]),
    .outflag(),
    .RIN(D2BUS),
    .checkout(),
    .ROUT(R));
    selector4to1 u_DST(
    .clk(clk),
    .T(T),
    .addr(DST),
    .D0(R),
    .D1(AX),
    .D2(DX),
    .D3(CX),
    .OUT(ALU_A));
    selector4to1 u_SRC(
    .clk(clk),
    .T(T),
    .addr(SRC),
    .D0(R),
    .D1(AX),
    .D2(DX),
    .D3(CX),
    .OUT(ALU_B));
    ALU  u_ALU (
    .A                       ( ALU_A),
    .B                       ( ALU_B),
    .T(T),
    .IMOV                    ( IMOV        ),
    .IADD                    ( IADD        ),
    .ISUB                    ( ISUB        ),
    .IMUL                    ( IMUL        ),
    .IDIV                    ( IDIV        ),
    .IOR                     ( IOR         ),
    .INOT                    ( INOT        ),
    .IAND                    ( IAND        ),
    .IXOR                    ( IXOR        ),
    .ISHL                    ( ISHL        ),
    .ISHR                    ( ISHR        ),
    .EALU                   ( EALU        ),
    .OUT                     (D2BUS)
    );
    
    
endmodule
