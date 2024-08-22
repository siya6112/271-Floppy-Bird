module winner (clk, reset, score, user, addOn);
	input logic clk, reset, score;
	output logic [6:0] user;
	output logic addOn; 
	
	enum {zero, one, two, three, four, five, six, seven, eight, nine} ps, ns;
	
	logic [6:0] hex0, hex1, hex2, hex3, hex4, hex5, hex6, hex7, hex8, hex9;
	assign hex0 = 7'b1000000;
	assign hex1 = 7'b1111001;
	assign hex2 = 7'b0100100;
	assign hex3 = 7'b0110000;
	assign hex4 = 7'b0011001; 
	assign hex5 = 7'b0010010; 
	assign hex6 = 7'b0000010; 
	assign hex7 = 7'b1111000; 
	assign hex8 = 7'b0000000; 
	assign hex9 = 7'b0010000; 
	
	
	always_comb begin
		case(ps)
			zero: if (score) ns = one;
					else ns = zero;
			one: if (score) ns = two;
					else ns = one;
			two: if (score) ns = three;
					else ns = two;
			three: if (score) ns = four;
					else ns = three;
			four: if (score) ns = five;
					else ns = four;
			five: if (score) ns = six;
					else ns = five;
			six: if (score) ns = seven;
					else ns = six;
			seven: if (score) ns = eight;
					else ns = seven;
			eight: if (score) ns = nine;
					else ns = eight;
			nine: if (score) ns = zero;
					else ns = nine;
		endcase
	end
	
	// Output logic for hex display
	always_comb begin
		case(ps)
			zero: user = hex0;
			one: user = hex1;
			two: user = hex2;
			three: user = hex3;
			four: user = hex4;
			five: user = hex5;
			six: user = hex6;
			seven: user = hex7;
			eight: user = hex8;
			nine: user = hex9;
		endcase
	end 
	
	always_comb begin
		case(ps) 
			nine: if (score) addOn = 1;
					else addOn = 0; 
			default: addOn = 0; 
		endcase
	end
	
	always_ff @(posedge clk) begin
		if(reset)
			ps <= zero;
		else
			ps <= ns;
	end
	
endmodule 