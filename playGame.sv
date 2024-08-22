module playGame (clk, reset, in, bird, sw, RedPixels, GrnPixels);
	input logic clk, reset, sw; 
	input logic [15:0] bird; 
	input logic [15:0][15:0] in;
	output logic [15:0][15:0] RedPixels, GrnPixels;

	enum {on, off} ps, ns;
	
	logic [15:0][15:0] endgame, during;
	
	assign during[00] = 0; 
	assign during[01] = 0; 
	assign during[02] = 0; 
	assign during[03] = 0; 
	assign during[04] = bird; 
	assign during[05] = 0; 
	assign during[06] = 0; 
	assign during[07] = 0; 
	assign during[08] = 0; 
	assign during[09] = 0; 
	assign during[10] = 0; 
	assign during[11] = 0; 
	assign during[12] = 0; 
	assign during[13] = 0; 
	assign during[14] = 0; 
	assign during[15] = 0; 
	
	assign endgame[0] = 16'b0000000000000000; 
	assign endgame[1] = 16'b0000000000000000;
	assign endgame[2] = 16'b0000000000000000;
	assign endgame[3] = 16'b0000000000000000;
	assign endgame[4] = 16'b0000000000000000;
	assign endgame[5] = 16'b0000000000000000;
	assign endgame[6] = 16'b0010010101110111;
	assign endgame[7] = 16'b0101010101000101;
	assign endgame[8] = 16'b0101010101110110;
	assign endgame[9] = 16'b0101010101000101;
	assign endgame[10] =16'b0010001001110101;
	assign endgame[11] =16'b0000000000000000;
	assign endgame[12] =16'b0000000000000000;
	assign endgame[13] =16'b0000000000000000;
	assign endgame[14] =16'b0000000000000000;
	assign endgame[15] =16'b000000000000000;

	
	always_comb begin 
		case (ps) 
			on: if (sw) ns = off; 
				 else ns = on; 
			off: ns = off; 
		endcase 
	end 
	
	always_comb begin 
		case(ps) 
			on: RedPixels = during; 
			off: RedPixels = endgame; 
		endcase
	end 
	
	always_comb begin 
		case(ps) 
			on: GrnPixels = in; 
			off: GrnPixels = '0;
		endcase
	end 
	
	always_ff @(posedge clk) begin 
		if (reset) 
			ps <= on; 
		else 
			ps <= ns; 
	end 
endmodule 