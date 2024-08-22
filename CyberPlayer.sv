module CyberPlayer(clk, reset, Q, SW, out);
	input logic clk, reset; 
	input logic [9:0] Q ;
	input logic [8:0] SW; 
	output logic out; 
	
	logic [9:0] temp; 
	
	assign temp = {1'b0, SW};
	
	comparator AI(.A(temp), .B(Q), .true_false(out)); 
endmodule 

module compButton_testbench();
	logic out;
	logic clk, reset;
	logic [9:0] Q;
	logic [8:0] SW;
	logic [9:0] SW_extend;
	
	compButton dut(.clk, .reset, .Q, .SW, .out);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD / 2) 
		clk <= ~clk;
	end
	
	initial begin
		reset <= 1;											@(posedge clk);
																@(posedge clk);
		reset <= 0;											@(posedge clk);
																@(posedge clk);
		Q = 10'b0000000001;	SW = 9'b000000010;	@(posedge clk);
																@(posedge clk);
		Q = 10'b0000000011;								@(posedge clk);
																@(posedge clk);
		$stop;
	end
endmodule