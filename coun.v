module coun(	input [2:0] abus_en,
					input rst, inc_en, clock,
					output wire [31:0] abus_in);
					
	reg [31:0] data = 0;
	//reg [31:0] abus = 0;
	initial begin
		data = 0;
	end
	/*
	always @(posedge clock)
		begin
			if (abus_en == 3'b110)
				abus <= data;
		end 
	*/
	always @(negedge clock)
		begin
			if (rst)
				data <= 32'b0;
			if (inc_en)
				data <= data + 1;
		end
		
	assign abus_in = data; 
	
endmodule 