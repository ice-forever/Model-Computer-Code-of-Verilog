//~ `New testbench
`timescale  1ns / 1ps

module tb_Computer;
// Computer Inputs
reg   clk100mhz                            = 0 ;
reg   RESET                                = 0 ;
reg   [15:0]  SW                           = 0 ;

// Computer Outputs
wire  [15:8]  LED                          ;
wire  [7:0]  AN                            ;
wire  [6:0]  seg                           ;


initial
begin
    forever #1  clk100mhz  =~clk100mhz;
end
// CPU Outputs
wire  [7:0]  AX                            ;
wire  [7:0]  DX                            ;
wire  [7:0]  R                             ;
wire  [7:0]  ABUS                          ;
wire  [7:0]  DBUS                          ;
wire  [7:0]  D2BUS                         ;
wire  [7:0]  T                             ;
wire  [7:0]  ALU_A                         ;
wire  [7:0]  ALU_B                         ;
wire  [7:0]  PC2MAR                        ;
wire  [7:0]  IROUT                         ;
wire  [3:0]  IRX                           ;
wire  [1:0]  SRC                           ;
wire  [1:0]  DST                           ;


assign RUN=SW[0];
assign LED[15:8]=T[7:0];
//仿真用
    clock_divide5 u_clk(
    .clk(clk100mhz),
    .CLEARn(RUN&~HALT),   //清零输入, 低有??
    .clk5(clk));
 /*
    clock_4hz u_clk(.clk(clk100mhz),
                 .CLEARn(RUN|~HALT),   //清零输入, 低有??
                 .clk4hz(clk));*/
                 
    CPU  u_CPU (
    .RUN                     ( RUN           ),
    .clk                     ( clk           ),
    .RESET                   ( RESET         ),

    .AX                      ( AX      [7:0] ),
    .DX                      ( DX      [7:0] ),
    .R                       ( R       [7:0] ),
    .ABUS                    ( ABUS    [7:0] ),
    .DBUS                    ( DBUS    [7:0] ),
    .D2BUS                   ( D2BUS   [7:0] ),
    .T                       ( T       [7:0] ),
    .ALU_A                   ( ALU_A   [7:0] ),
    .ALU_B                   ( ALU_B   [7:0] ),
    .PC2MAR                  ( PC2MAR  [7:0] ),
    .IROUT                   ( IROUT   [7:0] ),
    .IRX                     ( IRX     [3:0] ),
    .SRC                     ( SRC     [1:0] ),
    .DST                     ( DST     [1:0] ),
    .HALT(HALT)
);
wire [19:0]showAX,showDX;

bin_16toBCD_5 u_showAX(
    .B({8'd0,AX[7:0]}),
    .bcdout(showAX) );
bin_16toBCD_5 u_showDX(
    .B({8'd0,DX[7:0]}),
    .bcdout(showDX) );

seg7decimal u_show(
	.x({showAX[15:0],showDX[15:0]}),
	.clk(clk100mhz),
	.g_to_a(seg),
	.an(AN),
	.dp() );

initial
begin
    SW[0]=1;#1600;SW[0]=0;#500;SW[0]=1;#1600;RESET=1;#10;RESET=0;#3200;
    $stop;
end

endmodule
