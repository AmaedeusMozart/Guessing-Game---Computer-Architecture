`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:09:49 06/23/2016 
// Design Name: ??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
// Module Name:    Project2 
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

module Project2(
dp, 
bcd,
clk, 
led,
anodes,
button, 
switch2,
cathodes,   
temp_display0, 
temp_display1, 
temp_display2,
temp_display3,  
    );


input clk;
input [3:0] bcd;
input [3:0] button;
input [7:4] switch2;


output wire dp;
output reg [3:0] anodes;
output reg [6:0] cathodes;
output reg [6:0] temp_display0;
output reg [6:0] temp_display1;
output reg [6:0] temp_display2;
output reg [6:0] temp_display3;
output reg [7:0] led;


reg slow_clock;
reg [3:0] playervalue0;
reg [3:0] playervalue1; 
reg [3:0] playervalue2;
reg [3:0] playervalue3;
reg [3:0] player2value0;
reg [3:0] player2value1;
reg [3:0] player2value2;
reg [3:0] player2value3;
reg [15:0] finalvalueplayer1;
reg [15:0] finalvalueplayer2;
reg [1:0] flag_guesses = 2'b00;

integer valid = 0;
integer count1 = 0;
integer count2 = 0;
integer count3 =	0;
integer count4 = 0;
integer guesses = 0;
integer gamewon = 0;
integer playerflag = 0;
integer player1flag = 0;
integer player2flag = 0;

integer led_count =0;
integer buttonflag0 = 0;
integer buttonflag1= 0;
integer buttonflag2= 0;
integer buttonflag3= 0;
 
assign dp = 1;
 
always @ (posedge clk)
	begin
		create_slow_clock(clk, slow_clock); 
 
			if(switch2[4] == 1'b0 && player1flag != 1)
				begin
					playerflag = 0;					
					temp_display0 = 7'b1001111;
					temp_display1 = 7'b1111111;
					temp_display2 = 7'b1110001;
					temp_display3 = 7'b0011000;
					
				end

			else if(switch2[4] == 1'b1 && playerflag != 1)
				begin
					playerflag = 1;
					temp_display0 = 7'b0010010;
					temp_display1 = 7'b1111111;
					temp_display2 = 7'b1110001;
					temp_display3 = 7'b0011000;
					
				end	

		if(playerflag == 0 ) 
			begin
				if( button[0] == 1'b1)
					begin
						player1flag = 1;
						player2flag = 1;
						count1 = 1;				
									temp_display0 = display(bcd);
									playervalue0 = temp_display0;
								
								
					end
				
				else if(button[1] == 1'b1) 
					begin
						player1flag = 1;
						player2flag = 1;
						count2 =1;
									temp_display1 = display(bcd);	
									playervalue1 = temp_display1;
									
								
					end
					
				else if(button[2] == 1'b1)
					begin			
						player1flag =1;
						player2flag = 1;
						count3 =1;
						playervalue2 = temp_display2;
						temp_display2 = display(bcd);						
					end	
					
				else if(button[3] == 1'b1) 
					begin			
						player1flag = 1;
						player2flag = 1;
						count4 = 1;
						temp_display3 = display(bcd);
						playervalue3 = temp_display3;
						
					
					end
		
end	

if( playerflag == 1 || valid == 1 || valid == 2 )
	begin
			
				if( button[0] == 1'b1)
					begin									
									temp_display0 = display(bcd);									
									player2value0 = temp_display0;
					end
				
				else if(button[1] == 1'b1) 
					begin				
						temp_display1 = display(bcd);										
						player2value1 = temp_display1;
								
					end
					
				else if(button[2] == 1'b1)
					begin			
						temp_display2 = display(bcd);							
						player2value2 = temp_display2;
											
					end	
					
				else if(button[3] == 1'b1) 
					begin			
						temp_display3 = display(bcd);					
						player2value3 = temp_display3;
					
					end
		
end	

assign finalvalueplayer1 = {playervalue3, playervalue2, playervalue1, playervalue0};
assign finalvalueplayer2 = {player2value3, player2value2, player2value1, player2value0};

if(switch2[5] == 1'b1)
	begin
		flag_guesses = 2'b11;
	end
			if(switch2[5] == 1'b0 && flag_guesses == 2'b11)
				begin
					flag_guesses = 2'b00;
						if((finalvalueplayer1 > finalvalueplayer2) && gamewon != 1)
							begin	
								
								valid = 1;
									if(valid == 1)
										begin
										valid = 0;
									
										temp_display0 = 7'b0000001;
										temp_display1 = 7'b1110001;
										temp_display2 = 7'b1111111;				
										temp_display3 = 7'b0010010;	
										end
								end
						else if((finalvalueplayer1 < finalvalueplayer2) && gamewon != 1)
							begin
								
								valid = 2;
										if(valid == 2)
											begin										
										temp_display3 = 7'b0010010;
										temp_display2 = 7'b1111111;
										temp_display1 = 7'b1001000;
										temp_display0 = 7'b1001111;
									valid = 0;
								end
							end
						else if((finalvalueplayer1 == finalvalueplayer2))						
							begin
							
									gamewon = 1;
									temp_display1 = 7'b1111111;
									temp_display2 = 7'b1111111;
									temp_display3 = 7'b1111111;	
								

										case(guesses)
											0  : temp_display0 = 7'b0000001;
											1  : temp_display0 = 7'b1001111;
											2  : temp_display0 = 7'b0010010; 
											3  : temp_display0 = 7'b0000110;
											4  : temp_display0 = 7'b1001100;
											5  : temp_display0 = 7'b0100100;
											6  : temp_display0 = 7'b0100000;
											7  : temp_display0 = 7'b0001111;
											8  : temp_display0 = 7'b0000000;
											9  : temp_display0 = 7'b0000100;
											10 : temp_display0 = 7'b0001000;
											11 : temp_display0 = 7'b1100000;
											12 : temp_display0 = 7'b0110001;
											13 : temp_display0 = 7'b1000010;
											14 : temp_display0 = 7'b0110000;
											15 : temp_display0 = 7'b0111000;
									default  : temp_display0 = 7'b1111111;
										endcase
							end
								
					end
	
end
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
					
integer count7 = 0;
//Celebration LEDS
    always@(posedge slow_clock) 
    begin
       
            if (gamewon==1)
            begin
				if (count7>100)
				begin
				led = ~led;
				count7=0;
				end
				else
				count7= count7+1;
            end
        
    end

always @ (posedge flag_guesses[1])
begin
guesses <= guesses +1;
end
										

task create_slow_clock;
 
input clock;
inout slow_clock;
integer count;
 
	begin
			if (count > 25000)
				begin
					count=0;
					slow_clock = ~slow_clock;
				end
					count = count+1;
	end
endtask
 
 function [6:0] display; 
	input [3:0] bcd;
	begin
	
		case(bcd)
			0 : display = 7'b0000001;
			1 : display = 7'b1001111;
			2 : display = 7'b0010010;
			3 : display = 7'b0000110;
			4 : display = 7'b1001100;
			5 : display = 7'b0100100;
			6 : display = 7'b0100000;
			7 : display = 7'b0001111;
			8 : display = 7'b0000000;
			9 : display = 7'b0000100;
		  10 : display = 7'b0001000;
		  11 : display = 7'b1100000;
		  12 : display = 7'b0110001;
		  13 : display = 7'b1000010;
		  14 : display = 7'b0110000;
		  15 : display = 7'b0111000;
			default : display = 7'b1111111;
		endcase
	end
endfunction
				
endmodule
