module comparator(A, B, true_false);

	input logic [9:0] A, B; 
	output logic true_false;

	assign true_false = (A > B); 

endmodule 

module comparator_testbench();
	logic value_final;
	logic clk, reset;
	logic [9:0] A, B;
	
	comparator dut(.A, .B, .value_final);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD / 2)
		clk <= ~clk;
	end
	
	initial begin
		 	A = 10'b0010000001; B = 10'b0100000010; 	@(posedge clk);
																	@(posedge clk);
									  B = 10'b0000010000;	@(posedge clk);
																	@(posedge clk);
		$stop;
	end
endmodule