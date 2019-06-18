module ac(	input [31:0] cbus_out,
				input [7:0] dm_out,
				input [19:0] cm_out,
				input dm_wr, rst, clock, dm_r, cm_r, 
				input [2:0] abus_en,
				input [3:0] cbus_en,
				output wire [31:0] abus_in,
				output wire [7:0] dm_in);
	
	reg [31:0] data = 0;
	
		
	initial begin
		data = 0;
	end
	
	always @(negedge clock)
		begin
			if (rst)
				data <= 32'b0;
			if	(cbus_en == 4'b1011)
				data <= cbus_out;
			if (dm_r)
				data <= dm_out;
			if (cm_r)
				data <= cm_out; 
		end
		
	assign abus_in = data; 
	assign dm_in = data[7:0];
	
endmodule 
