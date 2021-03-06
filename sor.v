module sor(	input [31:0] cbus_out,
				input [2:0] abus_en,
				input [3:0] cbus_en,
				input rst, inc_en, clock,
				output wire [31:0] abus_in);
	
	
	reg [31:0] data;
	initial begin
		data = 0;
	end
	/*
	reg [31:0] abus;
	
	always @(posedge clock)
		begin 
			if (abus_en == 3'b001)
				abus <= data;
		end
		*/
	always @(negedge clock)
		begin
			if (rst)
				data <= 32'b0;
			if (inc_en)
				data <= data + 1;
			if (cbus_en == 4'b1001)
				data <= cbus_out; 
		end
		
	assign abus_in = data; 

endmodule 