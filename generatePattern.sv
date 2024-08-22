module generatePattern (clk, reset, enable, out);
	input logic clk, reset, enable; 
	output logic [15:0] out;
	
	logic [9:0] userIn; 
	
	LFSR l1 (.clk, .reset, .out(userIn)); 
	
	integer x, i, count; 
	
	always_ff @(posedge clk) begin
		if(reset) begin 
			out <= '0;
			count <= 7;
		end
		else if (enable & count == 0) begin
			count <= 7; 
			for (i = 0; i < 16; i++) begin 
				if (i < x | i > (x + 5)) 
					out[i] <= 1'b1; 
				else 
					out[i] <= 1'b0; 
			end 
		end 
		else if(enable & count == 1) begin
			x <= userIn % 9;
			count <= count - 1; 
		end
		else if (enable) begin
			count <= count - 1; 
			out <= '0; 
		end 
	end 
	
endmodule 