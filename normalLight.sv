module normalLight (clk, reset, button, fall, up, down, lightOn);
	input logic clk, reset, button, fall, up, down;
	output logic lightOn;
	
	
	enum {off, on} ps, ns;
	
	always_comb begin
		case(ps)
			off:	  if(button & down) ns = on;
					  else if (fall & up)ns = on;
					  else ns = off;
					  
			on: 	  if(button | fall) ns = off;
					  else ns = on;
			
		endcase
	end
	
	always_comb begin
		case(ps)
			on: lightOn = 1;
			
			off: lightOn = 0;
		endcase
	end
	
	always_ff @(posedge clk) begin
		if(reset) 
			ps <= off;
		else
			ps <= ns;
	end
endmodule 