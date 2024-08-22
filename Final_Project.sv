module Final_Project (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, SW, LEDR, GPIO_1, CLOCK_50);
	output logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0]  LEDR;
	input  logic [3:0]  KEY;
	input  logic [9:0]  SW;
	output logic [35:0] GPIO_1;
	input logic CLOCK_50;


//	assign HEX0 = '1;
//	assign HEX1 = '1;
//	assign HEX2 = '1;
//	assign HEX3 = '1;
//	assign HEX4 = '1;
//	assign HEX5 = '1;



	logic [31:0] clk;
	logic SYSTEM_CLOCK;

	clock_divider divider (.clock(CLOCK_50), .divided_clocks(clk));

	assign SYSTEM_CLOCK = clk[14]; 

	logic [15:0][15:0]RedPixels; 
	logic [15:0][15:0]GrnPixels; 
	logic RST;                   

	assign RST = SW[9];

	LEDDriver Driver (.CLK(SYSTEM_CLOCK), .RST, .EnableCount(1'b1), .RedPixels, .GrnPixels, .GPIO_1);

	logic player;

	UserInput user (.clk(SYSTEM_CLOCK), .key(~KEY[0]), .out(player));
	
	logic enable1, enable2; 

	clock_speed  avg (.clk(SYSTEM_CLOCK), .reset(RST), .enable(enable1));
	clock_speed #(336) fst (.clk(SYSTEM_CLOCK), .reset(RST), .enable(enable2));
	
	logic [15:0] birdlight;
	
	birdLight birdy (.clk(SYSTEM_CLOCK), .reset(RST), .button(player), .fall(enable1), .birdlight);
	
	logic gameEnd, score; 

	
	counter count (.clk(SYSTEM_CLOCK), .reset(RST), .green(GrnPixels[4][15:0]), .red(RedPixels[4][15:0]), .gameEnd, .score);
	
	logic h0, h1, h2, h3, h4, h5; 
	
	winner win1 (.clk(SYSTEM_CLOCK), .reset(RST), .score, .user(HEX0), .addOn(h0));
	winner win2 (.clk(SYSTEM_CLOCK), .reset(RST), .score(h0), .user(HEX1), .addOn(h1));
	winner win3 (.clk(SYSTEM_CLOCK), .reset(RST), .score(h1), .user(HEX2), .addOn(h2));
	winner win4 (.clk(SYSTEM_CLOCK), .reset(RST), .score(h2), .user(HEX3), .addOn(h3));
	winner win5 (.clk(SYSTEM_CLOCK), .reset(RST), .score(h3), .user(HEX4), .addOn(h4));
	winner win6 (.clk(SYSTEM_CLOCK), .reset(RST), .score(h4), .user(HEX5), .addOn(h5));
	
	logic [15:0] obstacle; 
	logic [15:0][15:0] obstacle_output;
	
	generatePattern pattern (.clk(SYSTEM_CLOCK), .reset(RST), .enable(enable2), .out(obstacle));
	move_obstacle move (.clk(SYSTEM_CLOCK), .reset(RST), .obstacle, .enable(enable2), .out(obstacle_output)); 
	
	playGame game (.clk(SYSTEM_CLOCK), .reset(RST), .in(obstacle_output), .bird(birdlight), .sw(gameEnd), .RedPixels, .GrnPixels);

endmodule 