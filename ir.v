module ir (	input [31:0] im_out,
				input [2:0] abus_en, bbus_en,
				input im_r, clock,
				output wire [31:0] bbus_in,
				output wire [31:0] abus_in);
	
	reg [31:0] data = 32'b0; 
	//reg [31:0] abus = 32'b0;
	//reg [31:0] bbus = 32'b0;
	initial begin
		data = 0;
	end
	/*
	always @(posedge clock)
		begin
			if (bbus_en == 3'b111)
				bbus[7:0] <= data[7:0];
			if (abus_en == 3'b111)
				abus <= data;
		end
	*/
	always @(negedge clock)
		begin 
			if (im_r == 1) 
				data <= im_out;
		end
		
	assign abus_in = data;
	assign bbus_in = data[7:0];
	
endmodule 