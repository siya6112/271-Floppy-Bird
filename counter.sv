module counter (clk, reset, green, red, gameEnd, score);
	input logic clk, reset;
	input logic [15:0] green, red;
	output logic gameEnd, score;
	
	logic points, finished, collide;
	integer i; 
	
	UserInput pI (.clk, .key(points), .out(score));
	UserInput fI (.clk, .key(finished), .out(gameEnd));
	
	
	always_ff @(negedge clk) begin
		for (i = 0; i < 16; i++) begin
			if (green[i] & red[i]) begin
				collide <= 1;
				break;
			end
			
			else begin
				collide <= 0;
			end
		end
	end
	
	
	always_ff @(posedge clk) begin
		if(reset) begin
			points <= 0; 
			finished <= 0;
		end
			
		else if(collide == 1 | red == 0) begin
			finished <= 1;
			points <= 0; 
		end
		
		else if(green[15] == 1) begin
			points <= 1; 
			finished <= 0;
		end
			
		else begin
			points <= 0; 
			finished <= 0;
		end
				
	end
	
endmodule 