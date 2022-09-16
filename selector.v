module selector4to1(input clk,
input [7:0]T,
    input [1:0]addr,
                     input [7:0]D0,
                     input [7:0]D1,
                     input [7:0]D2,
                     input [7:0]D3,
                     output reg [7:0]OUT);
    /*always @(T[7:0] ,addr)
    begin
        case(addr)
            2'b01 : OUT = D1;
            2'b10 : OUT = D2;
            2'b11:  OUT = D3;
            default: OUT = D0;
        endcase
    end*/
    always @(posedge clk) begin
        if(T[4]|T[2])    begin
        if(addr==2'b00)OUT=D0;
        else if(addr==2'b01)OUT=D1;
        else if(addr==2'b10)OUT=D2;
        else if(addr==2'b11)OUT=D3;
        end
        
    end
endmodule
