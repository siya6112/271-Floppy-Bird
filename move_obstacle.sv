module move_obstacle(clk, reset, obstacle, enable, out);
	input logic clk, reset, enable; 
	input logic [15:0] obstacle;
	output logic [15:0][15:0] out;

	integer i; 

	// GAME - 2 (Flappy Bird) 
	
//	always_ff @(posedge clk) begin 
//		if (reset) 
//			out <= '0; 
//		else if (enable) begin 
//			out[15] <= obstacle;
//			out[14] <= out[15]; 
//			out[13] <= out[14]; 
//			out[12] <= out[13]; 
//			out[11] <= out[12]; 
//			out[10] <= out[11]; 
//			out[9] <= out[10]; 
//			out[8] <= out[9]; 
//			out[7] <= out[8]; 
//			out[6] <= out[7]; 
//			out[5] <= out[6]; 
//			out[4] <= out[5]; 
//			out[3] <= out[4]; 
//			out[2] <= out[3]; 
//			out[1] <= out[2]; 
//			out[0] <= out[1];
//		end 
//		else out <= out; 
//	end 

	// GAME - 1 (Custom - Floppy Bird) 

	always_ff @(posedge clk) begin 
		if (reset) 
			out <= '0; 
		else if (enable) begin 
			for (i = 0; i < 16; i++) begin 
				out[i][15] <= obstacle;
				out[i][14] <= out[i][15]; 
				out[i][13] <= out[i][14]; 
				out[i][12] <= out[i][13]; 
				out[i][11] <= out[i][12]; 
				out[i][10] <= out[i][11]; 
				out[i][9] <= out[i][10]; 
				out[i][8] <= out[i][9]; 
				out[i][7] <= out[i][8]; 
				out[i][6] <= out[i][7]; 
				out[i][5] <= out[i][6]; 
				out[i][4] <= out[i][5]; 
				out[i][3] <= out[i][4]; 
				out[i][2] <= out[i][3]; 
				out[i][1] <= out[i][2]; 
				out[i][0] <= out[i][1];
			end
		end 
		else out <= out; 
	end 
	
endmodule 
