module LED_test(RST, RedPixels, GrnPixels);
    input logic               RST;
    output logic [15:0][15:0] RedPixels; // 16x16 array of red LEDs
    output logic [15:0][15:0] GrnPixels; // 16x16 array of green LEDs
	 
	 always_comb 
	 begin
		
		// Reset - Turn off all LEDs
		if (RST)
		begin
			RedPixels = '0;
			GrnPixels = '0;
		end
		
	  // Display a pattern
		else
		begin
		  //                  FEDCBA9876543210
		  RedPixels[00] = 'b0;
		  RedPixels[01] = 'b0;
		  RedPixels[02] = 'b0;
		  RedPixels[03] = 'b0;
		  RedPixels[04] = 'b0;
		  RedPixels[05] = 16'b0000011111100000;
		  RedPixels[06] = 16'b0000011111100000;
		  RedPixels[07] = 16'b0000011111100000;
		  RedPixels[08] = 16'b0000011111100000;
		  RedPixels[09] = 16'b0000011111100000;
		  RedPixels[10] = 16'b0000011111100000;
		  RedPixels[11] = 'b0;
		  RedPixels[12] = 'b0;
		  RedPixels[13] = 'b0;
		  RedPixels[14] = 'b0;
		  RedPixels[15] = 'b0;
		  
		  //                  FEDCBA9876543210
		  GrnPixels[00] = 'b0;
		  GrnPixels[01] = 'b0;
		  GrnPixels[02] = 'b0;
		  GrnPixels[03] = 'b0;
		  GrnPixels[04] = 'b0;
		  GrnPixels[05] = 16'b0000011111100000;
		  GrnPixels[06] = 16'b0000011111100000;
		  GrnPixels[07] = 16'b0000011111100000;
		  GrnPixels[08] = 16'b0000011111100000;
		  GrnPixels[09] = 16'b0000011111100000;
		  GrnPixels[10] = 16'b0000011111100000;
		  GrnPixels[11] = 'b0;
		  GrnPixels[12] = 'b0;
		  GrnPixels[13] = 'b0;
		  GrnPixels[14] = 'b0;
		  GrnPixels[15] = 'b0;
		end
	end

endmodule


module LED_test_testbench();

	logic RST;
	logic [15:0][15:0] RedPixels, GrnPixels;
	
	LED_test dut (.RST, .RedPixels, .GrnPixels);
	
	initial begin
	RST = 1'b1; #10;
	RST = 1'b0; #10;
	end
	
endmodule