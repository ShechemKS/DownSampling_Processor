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

/*
module BusA ( 	input clock,
					input [2:0] abus_en,
					input [31:0] ir, mar, sor, dstr, coun, ac,
					output wire [31:0] abus_out);
	
	reg [31:0] abus = 0;
	
	always @(abus_en or mar or sor or dstr or coun or ac or ir)
		
		case(abus_en)
			3'd1: assign abus_out <= sor;
			3'd2: assign abus_out <= dstr;
			3'd3: assign abus_out <= ac;
			3'd4: assign abus_out <= mar;
			3'd6:	assign abus_out <= coun;
			3'd7: abus <= ir; 
			
			default: abus <= 0; 
		endcase
	always @(abus_en)
		begin
			$display("a_bus = %d", abus);
		end
		
	assign abus_out = abus; 
	
endmodule
*/
module BusB(	input [2:0] bbus_en,
					input [31:0] reg1, reg2, reg3, ir,
					output wire [31:0] bbus_out);

		assign bbus_out = 	(bbus_en == 3'd4)? reg1:
									(bbus_en == 3'd5)? reg2:
									(bbus_en == 3'd6)? reg3:
									(bbus_en == 3'd7)? ir:32'd0;
									
endmodule
		
		
/*
module BusB(	input clock,
					input [2:0] bbus_en,
					input [31:0] reg1, reg2, reg3, ir,
					output wire [31:0] bbus_out);
	
	reg [31:0] bbus = 0;
					
	always @(reg1 or reg2 or reg3 or ir or bbus_en)
		
		case (bbus_en)
			3'd4: bbus <= reg1;
			3'd5: bbus <= reg2;
			3'd6: bbus <= reg3;
			3'd7: bbus <= ir;
			
			default: bbus <= 0;
		endcase 
	always @(reg1 or reg2 or reg3 or ir or bbus_en)
		begin
			$display("b_bus = %d", bbus);
		end
		
	assign bbus_out = bbus; 

endmodule 			
			*/
			