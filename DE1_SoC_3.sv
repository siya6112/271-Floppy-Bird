module DE1_SoC_3 (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	input logic CLOCK_50; // 50MHz clock.
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY; // True when not pressed, False when pressed
	input logic [9:0] SW;
	
	// Generate clk off of CLOCK_50, whichClock picks rate.
	
//	logic reset;
	logic [31:0] div_clk;
	
	parameter whichClock = 15;
	clock_divider cdiv (.clock(CLOCK_50),
								.reset(SW[9]),
								.divided_clocks(div_clk));
								
	assign clkSelect = div_clk[whichClock];
	
	// Clock selection; allows for easy switching between simulation and board
	// clocks
	logic key0, key3, input0, input3, autoReset, compInput;
	logic [9:0] LFSRoutput;

	
	assign HEX2 = 7'b1111111;
	assign HEX3 = 7'b1111111;
	assign HEX4 = 7'b1111111;
	assign HEX5 = 7'b1111111;
	
	DFlipFlop Flip0 (.clk(clkSelect), .reset(SW[9]), .key(~KEY[0]), .out(input0));
	DFlipFlop Flip3 (.clk(clkSelect), .reset(SW[9]), .key(compInput), .out(input3));
	
	UserInput human (.clk(clkSelect), .reset(SW[9]), .key(input0), .out(key0));
	UserInput computer (.clk(clkSelect), .reset(SW[9]), .key(input3), .out(key3));
	
	normalLight L1 (.clk(clkSelect), .reset(SW[9]), .L(key3), .R(key0), .NL(LEDR[2]), .NR(1'b0), .lightOn(LEDR[1]), .autoReset(autoReset));
	normalLight L2 (.clk(clkSelect), .reset(SW[9]), .L(key3), .R(key0), .NL(LEDR[3]), .NR(LEDR[1]), .lightOn(LEDR[2]), .autoReset(autoReset));
	normalLight L3 (.clk(clkSelect), .reset(SW[9]), .L(key3), .R(key0), .NL(LEDR[4]), .NR(LEDR[2]), .lightOn(LEDR[3]), .autoReset(autoReset));
	normalLight L4 (.clk(clkSelect), .reset(SW[9]), .L(key3), .R(key0), .NL(LEDR[5]), .NR(LEDR[3]), .lightOn(LEDR[4]), .autoReset(autoReset));	 
	centerLight L5 (.clk(clkSelect), .reset(SW[9]), .L(key3), .R(key0), .NL(LEDR[6]), .NR(LEDR[4]), .lightOn(LEDR[5]), .autoReset(autoReset));	 
	normalLight L6 (.clk(clkSelect), .reset(SW[9]), .L(key3), .R(key0), .NL(LEDR[7]), .NR(LEDR[5]), .lightOn(LEDR[6]), .autoReset(autoReset));
	normalLight L7 (.clk(clkSelect), .reset(SW[9]), .L(key3), .R(key0), .NL(LEDR[8]), .NR(LEDR[6]), .lightOn(LEDR[7]), .autoReset(autoReset));
	normalLight L8 (.clk(clkSelect), .reset(SW[9]), .L(key3), .R(key0), .NL(LEDR[9]), .NR(LEDR[7]), .lightOn(LEDR[8]), .autoReset(autoReset));
	normalLight L9 (.clk(clkSelect), .reset(SW[9]), .L(key3), .R(key0), .NL(1'b0), .NR(LEDR[8]), .lightOn(LEDR[9]), .autoReset(autoReset));
	
	LFSR out (.clk(clkSelect), .reset(SW[9]), .Q(LFSRoutput));
	CyberPlayer AImove (.clk(clkSelect), .reset(SW[9]), .Q(LFSRoutput), .SW(SW[8:0]), .out(compInput));
	
	counter displayWinner(.clk(clkSelect), .reset(SW[9]), .LED9(LEDR[9]), .LED1(LEDR[1]), .L(key3), .R(key0), .HEX1(HEX1), .HEX0(HEX0), .autoReset(autoReset));
	
endmodule

module DE1_SoC_testbench();
	logic 		CLOCK_50;
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;
	
	DE1_SoC dut (.CLOCK_50, .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD / 2)
		CLOCK_50 <= ~CLOCK_50;
	end
	
	initial begin
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
		SW[9] <= 1;											@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
		SW[9] <= 0;											@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
		KEY[0] <= 1; SW[8:0] = 9'b000000000;		@(posedge CLOCK_50);
																@(posedge CLOCK_50);
		KEY[0] <= 0;										@(posedge CLOCK_50);
																@(posedge CLOCK_50);
		KEY[0] <= 1;										@(posedge CLOCK_50);
																@(posedge CLOCK_50);
		KEY[0] <= 0;										@(posedge CLOCK_50);
																@(posedge CLOCK_50);
		KEY[0] <= 1; 										@(posedge CLOCK_50);
																@(posedge CLOCK_50);
		KEY[0] <= 0;										@(posedge CLOCK_50);
																@(posedge CLOCK_50);
		KEY[0] <= 1;										@(posedge CLOCK_50);
																@(posedge CLOCK_50);
		KEY[0] <= 0;										@(posedge CLOCK_50);
																@(posedge CLOCK_50);
		KEY[0] <= 1;										@(posedge CLOCK_50);
																@(posedge CLOCK_50);
		KEY[0] <= 0;										@(posedge CLOCK_50);
																@(posedge CLOCK_50);
		KEY[0] <= 1;										@(posedge CLOCK_50);
																@(posedge CLOCK_50);
		KEY[0] <= 0;										@(posedge CLOCK_50);
																@(posedge CLOCK_50);
		KEY[0] <= 1;										@(posedge CLOCK_50);
																@(posedge CLOCK_50);
		KEY[0] <= 0; 										@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
		SW[9] <= 1; 										@(posedge CLOCK_50);
																@(posedge CLOCK_50);
		SW[9] <= 0;											@(posedge CLOCK_50);
																@(posedge CLOCK_50);
		KEY[0] <= 0; SW[8:0] <= 9'b0111111110;		@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
																@(posedge CLOCK_50);
		$stop;
	end
endmodule