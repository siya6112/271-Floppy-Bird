module UserInput(clk, key, out);

	input logic clk, key; 
	output logic out; 

	enum {on, off} ps, ns;

	always_comb begin
		case(ps)
			on: 	if(key) ns = off;
					else ns = on;
					
			off: if(key) ns = off; 
					else ns = on; 
		endcase
	end 
	
	always_comb begin
		case (ps)
			on: if (key) out = 1'b1;
					else out = 1'b0;
			off: out = 1'b0;
		endcase
	end
	
	always_ff @(posedge clk) begin
		ps <= ns;
	end
endmodule  