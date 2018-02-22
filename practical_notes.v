/*############################################################
## Module: ECE 270 Lab Practical Review Notes
## Last Modified By: ***REMOVED TO PROTECT IDENTITY***
## Date: 12/3/17
############################################################*/
/*############################################################
## OVERVIEW: divides frequency to 2Hz and 1Hz (from 20MHz oscillator)
############################################################*/
reg CLK_out_2Hz;							//divided frequency to 2Hz
reg CLK_out_1Hz;							//divided frequency to 1Hz
always @(posedge tmr_out) begin 			// frequency divider
	if (DIP[7] == 1'b1) begin
		CLK_out_2Hz <= 0;
	end else begin
		CLK_out_2Hz <= !CLK_out_2Hz;
	end
end
always @(posedge CLK_out_2Hz) begin 		// frequency divider
	if (DIP[7] == 1'b1) begin
		CLK_out_1Hz <= 0;
	end else begin
		CLK_out_1Hz <= !CLK_out_1Hz;
		LED_YELLOW_R <= CLK_out_1Hz;		//debugging tool (comment out)  
	end
end
/*"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""*/
/*"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""*/
/*"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""*/
/*############################################################
## OVERVIEW: pseudo-random number generator for 4 bit numbers
############################################################*/
localparam A0  = 4'b0000;					
localparam A1  = 4'b0001;
localparam A2  = 4'b0010;
localparam A3  = 4'b0011;
localparam A4  = 4'b0100;
localparam A5  = 4'b0101;					// state definitions
localparam A6  = 4'b0110; 
localparam A7  = 4'b0111;
localparam A8  = 4'b1000;
localparam A9  = 4'b1001;
localparam A10 = 4'b1010;
localparam A11 = 4'b1011;
localparam A12 = 4'b1100;
localparam A13 = 4'b1101; 
localparam A14 = 4'b1110;
localparam A15 = 4'b1111; 
reg [3:0] pseudo; 							// state variable
reg [3:0] next_pseudo; 					// next state variable
always @ (posedge BFC1,posedge BFC2) begin // clocked by bounce-less switches
	if (BFC2 == 1 && BFC1 == 0) 			// reset state sequencer
		pseudo <= A0; 
	else if (BFC1 == 1 && BFC2 == 0) 		// next state
		pseudo <= next_pseudo;
end
always @ (pseudo) begin 					// sequence definition (pseudo-random)
	case (pseudo)
		default: next_pseudo <= A0;
		A0:  next_pseudo 	  <= A5;
		A1:  next_pseudo 	  <= A6;
		A2:  next_pseudo 	  <= A7;
		A3:  next_pseudo 	  <= A8;
		A4:  next_pseudo 	  <= A9;
		A5:  next_pseudo 	  <= A10;
		A6:  next_pseudo 	  <= A11;
		A7:  next_pseudo 	  <= A12;
		A8:  next_pseudo 	  <= A13;
		A9:  next_pseudo 	  <= A14;
		A10: next_pseudo 	  <= A15;
		A11: next_pseudo 	  <= A2;
		A12: next_pseudo 	  <= A3;
		A13: next_pseudo 	  <= A4;
		A14: next_pseudo 	  <= A14; 		// stops here, could be set to A0
		A15: next_pseudo 	  <= A1;
	endcase
	if (DIP[7] == 1) 						// display
		MIDRED[7:4] <= {pseudo}; 			// show number
	else if (DIP[7] == 0) 					// do not display
		MIDRED[7:4] <= 4'b0000; 			// hide number
end
/*"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""*/
/*"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""*/
/*"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""*/
/*############################################################
## OVERVIEW: bounce-less switch using push-button
############################################################*/
reg BFC2; 									// de-bounced switch variable
always @ (posedge S2_NC, posedge S2_NO) begin 
	if (S2_NC == 1'b1) begin				// if not pressed
		LED_YELLOW_L <= 0;					// LED = 0
		BFC2 <= 0;
	end else if (S2_NO == 1'b1) begin		// if pressed
		LED_YELLOW_L <= 1;					// LED = 1
		BFC2 <= 1;
	end else begin
		LED_YELLOW_L <= 0;					// LED = 0
		BFC2 <= 0;
	end
end
/*"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""*/
/*"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""*/
/*"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""*/
/*############################################################
## OVERVIEW: this is an example of a conditional state machine 
## This example was used in lab 11, as a combination lock
############################################################*/
reg [3:0] state, next_state;				// state register variables
localparam A0 = 4'b0000; 					// lock set, prompt user
localparam A1 = 4'b0001;					// prompt user
localparam A2 = 4'b0010;					// prompt user
localparam A3 = 4'b0011;					// prompt user
localparam A4 = 4'b0100;					// prompt user
localparam A5 = 4'b0101;					// prompt user
localparam A6 = 4'b0110; 					// prompt user
localparam A7 = 4'b0111;					// prompt user
localparam A8 = 4'b1000;					// lock opened, wait for AR
localparam A9 = 4'b1001; 					// alarm triggered, wait for AR
reg [7:0] key; 								// the lock combination  
reg [7:0] next_ring; 							// for ring counter
reg [7:0] shift_l; 							// in lab, generated pseudo-randomly
always @ (posedge BFC1,posedge DIP[7]) begin
	if (DIP[7] == 1'b1) begin
		key        <= {shift_l};			// grab the pseudo-random number for the key
		BOTRED     <= key; 					// show the key on bottom LEDs
		state  	   <= A0;					// first state
		MIDRED 	   <= 8'b00000001;			// self-correcting ring counter
	end else if (DIP[7] == 1'b0) begin	
		state 	   <= next_state;			// state register
		MIDRED	   <= next_ring;			// self-correcting ring counter
	end
end
always @ (MIDRED) begin
	case (state)
		// AR = DIP[7]. If conditions met, advance (A0:A7). Else, alarm triggered (A9). 
		A0: begin
			if (DIP[7]==1'b1) next_state = A0; 
			else if ((S2_NO==concat[0]) & (DIP[7]==1'b0)) next_state = A1;
			else next_state = A9;
			end
		A1: begin
			if (DIP[7]==1'b1) next_state = A0;
			else if ((S2_NO==concat[1]) & (DIP[7]==1'b0)) next_state = A2;
			else next_state = A9;
			end
		A2: begin
			if (DIP[7]==1'b1) next_state = A0;
			else if ((S2_NO==concat[2]) & (DIP[7]==1'b0)) next_state = A3;
			else next_state = A9;
			end
		A3: begin
			if (DIP[7]==1'b1) next_state = A0;
			else if ((S2_NO==concat[3]) & (DIP[7]==1'b0)) next_state = A4;
			else next_state = A9;
			end
		A4: begin
			if (DIP[7]==1'b1) next_state = A0;
			else if ((S2_NO==concat[4]) & (DIP[7]==1'b0)) next_state = A5;
			else next_state = A9;
			end
		A5: begin
			if (DIP[7]==1'b1) next_state = A0;
			else if ((S2_NO==concat[5]) & (DIP[7]==1'b0)) next_state = A6;
			else next_state = A9;
			end
		A6: begin
			if (DIP[7]==1'b1) next_state = A0;
			else if ((S2_NO==concat[6]) & (DIP[7]==1'b0)) next_state = A7;
			else next_state = A9;
			end
		A7: begin
			if (DIP[7]==1'b1) next_state = A0;
			else if ((S2_NO==concat[6]) & (DIP[7]==1'b0)) next_state = A8;
			else next_state = A9;
			end
		A8: begin							// OPEN
			JUMBO_G <= CLK_out_1Hz;			// flashing JUMBO_G
			if (DIP[7]==1'b1) next_state = A0;
			else next_state = A8;			// stay here until AR asserted
			DIS4 <= charO;
			DIS3 <= charP;
			DIS2 <= charE;
			DIS1 <= charN;
			end
		A9: begin							// ALARM
			JUMBO_R <= CLK_out_1Hz;			// flashing JUMBO_R
			if (DIP[7]==1'b1) next_state = A0;
			else next_state = A9;			// stay here until AR asserted
			end
	endcase
	// Self-Correcting Ring Counter
	next_ring[7] = MIDRED[6];
	next_ring[6] = MIDRED[5];
	next_ring[5] = MIDRED[4];
	next_ring[4] = MIDRED[3];
	next_ring[3] = MIDRED[2];
	next_ring[2] = MIDRED[1];
	next_ring[1] = MIDRED[0];
	next_ring[0] = !(MIDRED[6]|MIDRED[5]|MIDRED[4]|MIDRED[3]|MIDRED[2]|MIDRED[1]|MIDRED[0]);
end
/*"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""*/
/*"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""*/
/*"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""*/
/*############################################################
## OVERVIEW: comparator for two 4-bit numbers
############################################################*/
reg cf,nf,zf,vf; 	
reg [4:0] answer;							// sum or difference
reg [3:0] X,Y_dr,Y;						// addends or subtrahends
reg [3:0] P,G;								// for P and G equations
reg c2, c3;									// for carry equations
reg x_equals_y; 							// x = y
reg x_greaterthan_y; 						// x > y
reg x_lessthan_y;							// x < y
always @ ( DIP ) begin 					// grab UI from DIP[7:0]
	// subtractor 
	// note Y_dr is the diminished radix form of negated Y
	// Y = radix form of negated Y
	X 				<= {DIP[7],DIP[6],DIP[5],DIP[4]};
	Y_dr 			<= {~DIP[3],~DIP[2],~DIP[1],~DIP[0]}; 
	Y 				<= Y_dr+4'b0001;		// add 1 to a negative DR number to get R form
	answer 			<= X[3:0]+Y[3:0];		// adder
	TOPRED [3:0] 	<= answer[3:0];
	// need these equations for flags used for comparator
	P 				<= X^Y;
	G 				<= X&Y;
	c2 				<= G[2] | G[1] & P[2] | G[0] & P[1] & P[2] | 1 & P[0] & P[1] & P[2];
	c3 				<= G[3] | G[2] & P[3] | G[1] & P[2] & P[3] | G[0] & P[1] & P[2] & P[3] | 
						1 & P[0] & P[1] & P[2] & P[3]; 
	// [carry flag,negative flag,zero flag,overflow flag]
	cf 				<= answer[4]^1;			// additional bit of sum = carry flag
	nf 				<= answer[3];				// first bit of sum = negative flag
	zf 				<= (~answer[3] & ~answer[2] & ~answer[1] & ~answer[0]); // sum = 4'b0000, zf = 1
	vf 				<= (c2^c3);				// overflow flag employs carry equations (c2 and c3)
	TOPRED [7:4] 	<= {cf,nf,zf,vf};			// top-left four LEDS show the flags
	// comparator 
	x_equals_y 		<= zf;						// X = Y (EQUAL TO)
	x_greaterthan_y	<= (vf&nf)+(~vf&~nf&~zf);	// X > Y (GREATER THAN)
	x_lessthan_y 	<= nf^vf;					// X < Y (LESS THAN)
end
/*"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""*/
/*"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""*/
/*"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""*/
/*############################################################
## OVERVIEW: counter
############################################################*/
reg [7:0] tally;							// counting variable
always @ (posedge BFC1,posedge BFC2) begin
	if (BFC1 == 0 && BFC2 == 1) 			// asynchronous reset
		tally <= 8'b00000000;
	else if (BFC1 == 1 && BFC2 == 0)
		tally <= tally + 8'b00000001;		// add 1 to tally (can add any number)
end
/*"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""*/
/*"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""*/
/*"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""*/
/*############################################################
## OVERVIEW: left shifting scrolling display
############################################################*/
localparam def  = 4'b0000;
localparam gp_1 = 4'b0001;
localparam gp_2 = 4'b0010;
localparam gp_3 = 4'b0011;
localparam gp_4 = 4'b0100;					// states 
localparam gp_5 = 4'b0101;
localparam gp_6 = 4'b0110;
localparam gp_7 = 4'b0111;
localparam gp_8 = 4'b1000;
localparam gp_9 = 4'b1001;
reg [6:0] state;
reg [6:0] next_state;
always @ (posedge CLK_out_1Hz, posedge DIP[7]) begin
	if (DIP[7] == 1) begin 					// asynchronous reset 
		state 	 <= def;
	end else begin
		state    <= next_state;				// sequence 
	end
end
always @ (state) begin
	case(state)
	def: begin
		if (DIP[7] == 1) begin
			next_state <= def;				// scrolling off
			DIS1 <= blank;
			DIS2 <= blank;
			DIS3 <= blank;
			DIS4 <= blank;
		end else if (DIP[1]==1) begin
			next_state <= gp_1;				// scroll on
			DIS1 <= charG;
			DIS2 <= blank;
			DIS3 <= blank;
			DIS4 <= blank;
		end
	gp_1: begin
		if (DIP[1]==1) begin
			next_state <= gp_2;
			DIS1 <= charO;
			DIS2 <= charG;
			DIS3 <= blank;
			DIS4 <= blank;
		end else next_state <= gp_1;		//stop here
		end
	gp_2: begin
		if (DIP[1]==1) begin
			next_state <= gp_3;
			DIS1 <= blank;
			DIS2 <= charO;
			DIS3 <= charG;
			DIS4 <= blank;
		end else next_state <= gp_2;
		end 
	gp_3: begin
		if (DIP[1]==1) begin
			next_state <= gp_4;
			DIS1 <= charP;
			DIS2 <= blank;
			DIS3 <= charO;
			DIS4 <= charG;
		end else next_state <= gp_3;
		end
	gp_4: begin
		if (DIP[1]==1) begin
			next_state <= gp_5;
			DIS1 <= charU;
			DIS2 <= charP;
			DIS3 <= blank;
			DIS4 <= charO;
		end else next_state <= gp_4;
		end
	gp_5: begin
		if (DIP[1]==1) begin
			next_state <= gp_6;
			DIS1 <= charR;
			DIS2 <= charU;
			DIS3 <= charP;
			DIS4 <= blank;
		end else next_state <= gp_5;
		end
	gp_6: begin
		if (DIP[1]==1) begin
			next_state <= gp_7;
			DIS1 <= charD;
			DIS2 <= charR;
			DIS3 <= charU;
			DIS4 <= charP;
		end else next_state <= gp_6;
		end
	gp_7: begin
		if (DIP[1]==1) begin
			next_state <= gp_8;
			DIS1 <= charU;
			DIS2 <= charD;
			DIS3 <= charR;
			DIS4 <= charU;
		end else next_state <= gp_7;
		end
	gp_8: begin
		if (DIP[1]==1) begin
			next_state <= gp_9;
			DIS1 <= charE;
			DIS2 <= charU;
			DIS3 <= charD;
			DIS4 <= charR;
		end else next_state <= gp_8;
		end
	gp_9: begin
		if (DIP[1]==1) begin
			next_state <= def;
			DIS1 <= blank;
			DIS2 <= charE;
			DIS3 <= charU;
			DIS4 <= charD;
		end else next_state <= gp_9;
		end
/*"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""*/
/*"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""*/
/*"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""*/