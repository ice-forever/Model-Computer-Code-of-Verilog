`timescale 1ns / 1ps

module rhythm (input clk,
               input CLEARn,       //«Â¡„ ‰»Î, µÕ”–????
               output reg [7:0]T);
    initial begin
        T = 8'd1;
    end
    always @(posedge clk or negedge CLEARn) begin
        if(CLEARn==1'b0) T=8'd1;
        else T = {T[6:0],T[7]};
    end
endmodule
module tb_rhythm;

// rhythm Parameters
parameter PERIOD  = 10;


// rhythm Inputs
reg   clk                                  = 0 ;
reg   CLEARn                               = 1 ;

// rhythm Outputs
wire  [7:0]  T                             ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

rhythm  u_rhythm (
    .clk                     ( clk           ),
    .CLEARn                  ( CLEARn        ),

    .T                       ( T       [7:0] )
);

initial
begin
    #10000;
    $stop;
end

endmodule