module reg3(	input [31:0] cbus_out,
					input clock,
					input [3:0] cbus_en,
					input [2:0] bbus_en,
					output wire [31:0] bbus_in);
					
	reg [31:0] data = 0;
	initial begin
		data = 0;
	end
	/*
	reg [31:0] b_out = 0;
	
	always @(posedge clock)
		begin 
			if (bbus_en == 3'b110)
				b_out <= data;
		end 
	*/
	always @(negedge clock)
		begin
			if (cbus_en == 4'b0110)
				data <= cbus_out;
		end
		
	assign bbus_in = data; 

endmodule 
