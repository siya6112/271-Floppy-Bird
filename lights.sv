module lights (clk, reset, SW, out);
	input logic [1:0] SW;
	input logic clk, reset;
	output logic [2:0] out; 
	
	// State variables
	enum logic [2:0] { center=3'b010, right_left=3'b001, left_right=3'b100, calm=3'b101} ps, ns;
	assign s0 = SW[0];
	assign s1 = SW[1];

	// Next State logic
	always_comb begin
		case (ps)
			center:	if (~s1 & ~s0)
							ns = calm;
						else if (~s1 & s0)
							ns = left_right;
						else
							ns = right_left;
			right_left:	if (~s1)
								ns = center;
							else
								ns = left_right;
			left_right:	if (~s1)
								ns = right_left;
							else 
								ns = center;
			calm:				ns = center;
		endcase
	end
	
	// Output logic - could also be another always_comb block.
	assign out = ps;                                
	
	// DFFs
	always_ff @(posedge clk) begin
		if (reset)
			ps <= calm;
		else
			ps <= ns;
	end
endmodule


module lights_testbench();
	logic [1:0] SW;
	logic [2:0] out;
	logic clk, reset;
	
	lights dut ( .clk, .reset, .SW, .out);
	
	// Set up a simulated clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
	end
	
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
		@(posedge clk);
		reset <= 1;	 @(posedge clk);
		reset <= 0;	 @(posedge clk);
		SW <= 2'b00; @(posedge clk);
						 @(posedge clk);
						 @(posedge clk);
		SW <= 2'b01; @(posedge clk);
						 @(posedge clk);
						 @(posedge clk);
		SW <= 2'b10; @(posedge clk);
						 @(posedge clk);
						 @(posedge clk);
		$stop; // End the simulation.
	end
endmodule