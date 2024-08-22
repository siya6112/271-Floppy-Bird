module clock_speed #(parameter sp = 762) (clk, reset, enable);

	input logic clk, reset;
	output logic enable; 
	
	integer count; 
	
	always_ff @(posedge clk) begin 
		if (count == 0 | reset)
			count <= sp; 
		else 
			count <= count - 1; 
	end 
	
	assign enable = (count == 0); 
endmodule 