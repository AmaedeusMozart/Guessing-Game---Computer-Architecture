`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:58:37 07/17/2017 
// Design Name: 
// Module Name:    Project1 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Project1(sw, ld, bcd, button, clk, cathodes, anodes, temp_display0, temp_display1, temp_display2, temp_display3 , dp
    );
	 
input clk;
reg slow_clock;
input wire [3:0] sw;
input [3:0] bcd;
input [3:0] button;
output wire [3:0] ld;
output reg [6:0] temp_display0;
output reg [6:0] temp_display1;
output reg [6:0] temp_display2;
output reg [6:0] temp_display3;
output reg [6:0] cathodes;
output reg [3:0] anodes;
output wire dp;


assign ld = sw;
assign dp = 1;

initial 
begin
temp_display0 = 7'b0000001;
temp_display1 = 7'b0000001;
temp_display2 = 7'b0000001;
temp_display3 = 7'b0000001;
end

always@( posedge button[0]) begin
        case (bcd)
            0 : temp_display0 = 7'b0000001;
            1 : temp_display0 = 7'b1001111;
            2 : temp_display0 = 7'b0010010;
            3 : temp_display0 = 7'b0000110;
            4 : temp_display0 = 7'b1001100;
            5 : temp_display0 = 7'b0100100;
            6 : temp_display0 = 7'b0100000;
            7 : temp_display0 = 7'b0001111;
            8 : temp_display0 = 7'b0000000;
            9 : temp_display0 = 7'b0000100;
			  10 : temp_display0 = 7'b0001000;
			  11 : temp_display0 = 7'b1100000;
			  12 : temp_display0 = 7'b0110001;
			  13 : temp_display0 = 7'b1000010;
			  14 : temp_display0 = 7'b0110000;
			  15 : temp_display0 = 7'b0111000;
           default : temp_display0 = 7'b1111111;
        endcase
	 end

always@(posedge button[1]) begin
case(bcd)
		   0 : temp_display1 = 7'b0000001;
            1 : temp_display1 = 7'b1001111;
            2 : temp_display1 = 7'b0010010;
            3 : temp_display1 = 7'b0000110;
            4 : temp_display1 = 7'b1001100;
            5 : temp_display1 = 7'b0100100;
            6 : temp_display1 = 7'b0100000;
            7 : temp_display1 = 7'b0001111;
            8 : temp_display1 = 7'b0000000;
            9 : temp_display1 = 7'b0000100;
			  10 : temp_display1 = 7'b0001000;
			  11 : temp_display1 = 7'b1100000;
			  12 : temp_display1 = 7'b0110001;
			  13 : temp_display1 = 7'b1000010;
			  14 : temp_display1 = 7'b0110000;
			  15 : temp_display1 = 7'b0111000;
             default : temp_display1 = 7'b1111111;
endcase
end

always@(posedge button[2]) begin
case(bcd)
		  0 : temp_display2 = 7'b0000001;
            1 : temp_display2 = 7'b1001111;
            2 : temp_display2 = 7'b0010010;
            3 : temp_display2 = 7'b0000110;
            4 : temp_display2 = 7'b1001100;
            5 : temp_display2 = 7'b0100100;
            6 : temp_display2 = 7'b0100000;
            7 : temp_display2 = 7'b0001111;
            8 : temp_display2 = 7'b0000000;
            9 : temp_display2 = 7'b0000100;
			  10 : temp_display2 = 7'b0001000;
			  11 : temp_display2 = 7'b1100000;
			  12 : temp_display2 = 7'b0110001;
			  13 : temp_display2 = 7'b1000010;
			  14 : temp_display2 = 7'b0110000;
			  15 : temp_display2 = 7'b0111000;
             default : temp_display2 = 7'b1111111; 
endcase
end
	
	
always@(posedge button[3]) begin
case(bcd)
		  0 : temp_display3 = 7'b0000001;
            1 : temp_display3 = 7'b1001111;
            2 : temp_display3 = 7'b0010010;
            3 : temp_display3 = 7'b0000110;
            4 : temp_display3 = 7'b1001100;
            5 : temp_display3 = 7'b0100100;
            6 : temp_display3 = 7'b0100000;
            7 : temp_display3 = 7'b0001111;
            8 : temp_display3 = 7'b0000000;
            9 : temp_display3 = 7'b0000100;
			  10 : temp_display3 = 7'b0001000;
			  11 : temp_display3 = 7'b1100000;
			  12 : temp_display3 = 7'b0110001;
			  13 : temp_display3 = 7'b1000010;
			  14 : temp_display3 = 7'b0110000;
			  15 : temp_display3 = 7'b0111000;   
            default : temp_display3 = 7'b1111111; 
endcase
end


task create_slow_clock;
 input clock;
 inout slow_clock;
 integer count;
 begin
 if (count > 250000)
 begin
 count=0;
 slow_clock = ~slow_clock;
 end
 count = count+1;
 end
 endtask

always @(posedge clk)
 create_slow_clock(clk, slow_clock); 
 
 always @(posedge slow_clock)
 begin
 case (anodes)
 4'b 1110: anodes = 4'b 1101;
 4'b 1101: anodes = 4'b 1011;
 4'b 1011: anodes = 4'b 0111;
 4'b 0111: anodes = 4'b 1110; 
	default: anodes=1111;
 endcase 
 case (anodes)
 4'b 1110: cathodes=temp_display3;
 4'b 1101: cathodes=temp_display2;
 4'b 1011: cathodes=temp_display1;
 4'b 0111: cathodes=temp_display0;
		default: anodes=1111;
	endcase
	end
	
endmodule
