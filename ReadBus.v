// Bus A and B

module BusA( 	input [2:0] abus_en,
					input [31:0] ir, mar, sor, dstr, coun, ac,
					output wire [31:0] abus_out);

	assign abus_out = 	(abus_en == 3'd1)? sor:
								(abus_en == 3'd2)? dstr:
								(abus_en == 3'd3)? ac:
								(abus_en == 3'd4)? mar:
								(abus_en == 3'd6)? coun:
								(abus_en == 3'd7)? ir:32'd0;
endmodule


module BusB(	input [2:0] bbus_en,
					input [31:0] reg1, reg2, reg3, ir,
					output wire [31:0] bbus_out);

		assign bbus_out = 	(bbus_en == 3'd4)? reg1:
									(bbus_en == 3'd5)? reg2:
									(bbus_en == 3'd6)? reg3:
									(bbus_en == 3'd7)? ir:32'd0;
									
endmodule
		
