module 	ece_270_lab_code 	(
							DIP, 
							i_S1_NC, 
							i_S1_NO, 
							i_S2_NC, 
							i_S2_NO, 
							o_TOPRED, 
							o_MIDRED, 
							o_BOTRED, 
							o_DIS1, 
							o_DIS2, 
							o_DIS3, 
							o_DIS4, 
							o_JUMBO, 
							o_LED_YELLOW
							//i_clk
							);
					
	// ====== DO NOT MODIFY BELOW ======
	// added sys clk for simulation
	//input wire			i_clk; // SYSTEM clock
	// PLD I/O 
	input wire [7:0]	DIP /*synthesis loc="26,25,24,23,76,77,78,79"*/; // DIP switches (MSB on the left)
	input wire 			i_S1_NC /*synthesis loc="58"*/; // ACTIVE LOW normally closed (down position) 
	input wire 			i_S1_NO /*synthesis loc="59"*/; // ACTIVE LOW normally opened (up position) 
	input wire 			i_S2_NC /*synthesis loc="60"*/; // ACTIVE LOW normally closed (down position) 
	input wire 			i_S2_NO /*synthesis loc="61"*/; // ACTIVE LOW normally opened (up position)
	output wire [7:0] 	o_TOPRED /*synthesis loc="28,29,30,31,32,33,39,40"*/; // ACTIVE LOW first row of LED (from top, MSB on the left) 
	output wire [7:0] 	o_MIDRED /*synthesis loc="130,131,132,133,134,135,138,139"*/; // ACTIVE LOW second row of LED (from top, MSB on the left) 
	output wire [7:0] 	o_BOTRED /*synthesis loc="112,111,105,104,103,102,101,100"*/; // ACTIVE LOW third row of LED (from top, MSB on the left)
	output wire [6:0] 	o_DIS1 /*synthesis loc="87,86,85,84,83,81,80"*/; // ACTIVE LOW right most 7-segment 
	output wire [6:0] 	o_DIS2 /*synthesis loc="98,97,96,95,94,93,88"*/; // ACTIVE LOW second right most 7-segment 
	output wire [6:0] 	o_DIS3 /*synthesis loc="125,124,123,122,121,120,116"*/; // ACTIVE LOW second left most 7-segment 
	output wire [6:0] 	o_DIS4 /*synthesis loc="44,48,49,50,51,52,53"*/; // ACTIVE LOW left most 7-segment
	output wire [3:0] 	o_JUMBO /*synthesis loc="143,142,141,140*/; // ACTIVE LOW Jumbo R-Y-G LED (unused, RED, YELLOW, GREEN)
	output wire [1:0] 	o_LED_YELLOW /*synthesis loc="62,63*/; // ACTIVE LOW yellow LED next to pushbuttons

	// Active low registers 
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
	// Oscillator
	// wire osc_dis, tmr_rst, osc_out, tmr_out; 
	// assign osc_dis = 1'b0; 
	// assign tmr_rst = 1'b0;
	// defparam I1.TIMER_DIV = "1048576"; 
	// OSCTIMER I1 (.DYNOSCDIS(osc_dis), .TIMERRES(tmr_rst), .OSCOUT(osc_out), .TIMEROUT(tmr_out));

	// 7-segment alphanumeric display code 
	localparam blank = " ";//7'b0000000; 
	localparam char0 = "0";//7'b1111110; 
	localparam char1 = "1";//7'b0110000; 
	localparam char2 = "2";//7'b1101101;
	localparam char3 = "3";//7'b1111001;
	localparam char4 = "4";//7'b0110011; 
	localparam char5 = "5";//7'b1011011; 
	localparam char6 = "6";//7'b1011111; 
	localparam char7 = "7";//7'b1110000; 
	localparam char8 = "8";//7'b1111111; 
	localparam char9 = "9";//7'b1111011;
	localparam charA = "A";//7'b1110111; 
	localparam charB = "B";//7'b0011111;
	localparam charC = "C";//7'b1001110; 
	localparam charD = "D";//7'b0111101; 
	localparam charE = "E";//7'b1001111; 
	localparam charF = "F";//7'b1000111; 
	localparam charG = "G";//7'b1111011;
	localparam charH = "H";//7'b0110111; 
	localparam charI = "I";//7'b0010000; 
	localparam charJ = "J";//7'b0111000; 
	localparam charL = "L";//7'b0001110; 
	localparam charN = "N";//7'b0010101;
	localparam charO = "O";//7'b0011101;
	localparam charP = "P";//7'b1100111;
	localparam charR = "R";//7'b0000101;
	localparam charS = "S";//7'b1011011;
	localparam charU = "U";//7'b0111110;
	localparam charY = "Y";//7'b0111011;
	// ====== DO NOT MODIFY ABOVE ======//
	/*************************************************************************
	 * Write code below.
	 *************************************************************************/
	// Step 1  
	always @(DIP) begin
		if (DIP[7] == 1) begin	// DIP[7] is reset
			LED_YELLOW_L	= 0;
			LED_YELLOW_R    = 0;
			JUMBO_R         = 0;
			JUMBO_Y         = 0;
			JUMBO_G         = 0;
			DIS1			= blank;
			DIS2			= blank;
			DIS3			= blank;
			DIS4			= blank;
			BOTRED			= 8'b00000000;
			MIDRED			= 8'b00000000;
			TOPRED			= 8'b00000000;		
		end 
		else begin
			DIS1 			= charU; 
			DIS2 			= charP; 
			DIS3 			= charO; 
			DIS4 			= charG; 
		end 
	end
endmodule