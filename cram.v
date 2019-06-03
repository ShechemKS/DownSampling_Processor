// Constant Memory

module cram( input clock, cm_r, 
				 input [2:0] cm_addr, 
				 output reg [19:0] cm_out);
				 
	reg [19:0] memory [7:0];
	
	initial begin
		//$readmemb("Const_Mem.mem", memory)
		/*
		memory[3] = 20'd0; // first address of source image
		memory[4] = 20'd10000; // first address of destination image 
		memory[5] = 20'd8259; // last address of source image
		memory[6] = 20'd118; // width of the source image
		*/
	end 
	
	always @(posedge clock)
		begin
			if (cm_r == 1)
				cm_out <= memory[cm_addr];
		end
endmodule 