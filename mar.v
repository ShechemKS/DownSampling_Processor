module mar(	input [31:0] cbus_out,
				input [2:0] abus_en,
				input [3:0] cbus_en,
				input inc_en, rst, clock, dm_wr, dm_r, cm_r,
				output wire [19:0] dm_addr,
				output wire [2:0] cm_addr, 
				output wire [31:0] abus_in,
				output wire [8:0] dat);
	
/*	reg [31:0] abus = 0;
	reg [2:0] cm = 0;
	reg [19:0] dm = 0;*/
	reg [31:0] data = 0;
	initial begin
		data = 0;
	end
/*
	always @(posedge clock)
		begin
			if (abus_en == 3'b100)
				abus <= data;
			if (dm_wr == 1)
				dm <= data[19:0];
			if (dm_r == 1)
				dm <= data[19:0];
			if (cm_r == 1)
				cm <= data[2:0];
		end
*/	
	always @(negedge clock)
		begin
			if (rst == 1'b1)
				data <= 32'b0;
			if (inc_en == 1'b1)
				data <= data + 1;
			if (cbus_en == 4'b1100)
				data <= cbus_out; 
		end
	
	assign abus_in = data;
	assign dm_addr = data[19:0]; 
	assign cm_addr = data[2:0]; 
	assign dat = data[8:0];
				
endmodule 