module reg2(	input [31:0] cbus_out,
					input clock,
					input [3:0] cbus_en,
					input [2:0] bbus_en,
					output wire [31:0] bbus_in);
					
	reg [31:0] data = 0;
	initial begin
		data = 0;
	end
	
	always @(negedge clock)
		begin
			if (cbus_en == 4'b0101)
				data <= cbus_out;
		end
	
	assign bbus_in = data; 

endmodule 
