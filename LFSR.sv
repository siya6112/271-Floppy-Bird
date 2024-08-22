module LFSR(clk, reset, out);
	input logic clk, reset;
	output logic [9:0] out;
	logic xnor_out;
	
	xnor xn1 (xnor_out, out[3], out[0]);
	DFlipFlop dff1 (.d(xnor_out), .q(out[9]), .clk, .reset);
	DFlipFlop dff2 (.d(out[9]), .q(out[8]), .clk, .reset);
	DFlipFlop dff3 (.d(out[8]), .q(out[7]), .clk, .reset);
	DFlipFlop dff4 (.d(out[7]), .q(out[6]), .clk, .reset);
	DFlipFlop dff5 (.d(out[6]), .q(out[5]), .clk, .reset);
	DFlipFlop dff6 (.d(out[5]), .q(out[4]), .clk, .reset);
	DFlipFlop dff7 (.d(out[4]), .q(out[3]), .clk, .reset);
	DFlipFlop dff8 (.d(out[3]), .q(out[2]), .clk, .reset);
	DFlipFlop dff9 (.d(out[2]), .q(out[1]), .clk, .reset);
	DFlipFlop dff10 (.d(out[1]), .q(out[0]), .clk, .reset);
endmodule 