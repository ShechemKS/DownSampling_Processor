module pc( 	input [31:0] cbus_out,
				input im_r, inc_en, clock,rst,
				input [3:0] cbus_en,
				input [1:0] status,
				output wire [9:0] im_addr);
	
	reg [9:0] data = 10'b0;
	//reg [9:0] data = 10'b0;
	initial begin
		data = 0;
	end

/*
	always @(posedge clock)
		begin
			if (im_r == 1)
				dataout <= datain; 
		end
*/	
	always @(negedge clock)
		begin
			if (inc_en)
				data <= data + 1;
			if (cbus_en == 4'b1110)
				data <= cbus_out[9:0];
			if (rst)
				data <= 0;
		end
	
	assign im_addr = data; 
				
endmodule 