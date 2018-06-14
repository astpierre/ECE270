// ECE 270 Verilog Lab TB
// Written by: Andrew St. Pierre
// Last edited: June 13, 2018
module ece_270_lab_code_tb;
	
	// Inputs
	//reg i_clk; // SYSTEM clock
	
	reg [7:0] DIP;
	wire i_S1_NC;
	wire i_S1_NO;
	wire i_S2_NC;
	wire i_S2_NO;
	
	// Outputs
	wire [7:0] o_TOPRED;
	wire [7:0] o_MIDRED;
	wire [7:0] o_BOTRED;
	wire [6:0] o_DIS1;
	wire [6:0] o_DIS2;
	wire [6:0] o_DIS3;
	wire [6:0] o_DIS4;
	wire [3:0] o_JUMBO; //R-Y-G LED (unused, RED, YELLOW, GREEN)
	wire [1:0] o_LED_YELLOW; // small Y LED next to pushbuttons

	wire i_clk;

	// Active low wires / registers 
	//reg 				clk; // clocking agent
	wire 				S1_NC, S1_NO, S2_NC, S2_NO; 
	reg [7:0] 			TOPRED; 
	reg [7:0] 			MIDRED; 
	reg [7:0] 			BOTRED; 
	reg [6:0] 			DIS1; 
	reg [6:0] 			DIS2; 
	reg [6:0] 			DIS3; 
	reg [6:0] 			DIS4; 
	reg 				JUMBO_unused, JUMBO_R, JUMBO_Y, JUMBO_G; 
	reg 				LED_YELLOW_L, LED_YELLOW_R;
	reg				clk = 0;
	// Active low assignment 
	assign 				S1_NC = ~i_S1_NC; 
	assign 				S1_NO = ~i_S1_NO; 
	assign 				S2_NC = ~i_S2_NC;
	assign 				S2_NO = ~i_S2_NO; 
	assign 				o_TOPRED = ~TOPRED; 
	assign 				o_MIDRED = ~MIDRED; 
	assign 				o_BOTRED = ~BOTRED; 
	assign 				o_DIS1 = ~DIS1; 
	assign 				o_DIS2 = ~DIS2; 
	assign 				o_DIS3 = ~DIS3; 
	assign 				o_DIS4 = ~DIS4; 
	assign 				o_JUMBO = {~JUMBO_unused, ~JUMBO_G, ~JUMBO_Y, ~JUMBO_R}; 
	assign 				o_LED_YELLOW = {~LED_YELLOW_L, ~LED_YELLOW_R};
	assign				i_clk = ~clk;
	// Instantiate the Unit Under Test (UUT)
	ece_270_lab_code 	uut	(
							.DIP(DIP), 
							.i_S1_NC(i_S1_NC),
							.i_S1_NO(i_S1_NO), 
							.i_S2_NC(i_S2_NC), 
							.i_S2_NO(i_S2_NO),
							.o_TOPRED(o_TOPRED),
							.o_MIDRED(o_MIDRED),
							.o_BOTRED(o_BOTRED),
							.o_DIS1(o_DIS1),
							.o_DIS2(o_DIS2),
							.o_DIS3(o_DIS3),
							.o_DIS4(o_DIS4),
							.o_JUMBO(o_JUMBO),
							.o_LED_YELLOW(o_LED_YELLOW),
							.i_clk(i_clk)
							);
  	
	initial begin
		DIP 			= 8'b11111111;
		#5;
	end
	
	always begin
		#5 clk = !clk;
	end
	
	always begin
		#20;
		DIP				= 8'b01111111;
	end
endmodule