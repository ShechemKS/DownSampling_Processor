module alu(	input [31:0] abus_out, bbus_out,
				input [2:0] alu_op,
				output wire [31:0] cbus_in, 
				output wire n, z);

	parameter 
	MOVA = 3'd0,
	MOVB = 3'd1,
	ADD = 3'd2, 
	SUB = 3'd3, 
	MUL = 3'd4, 
	DIV = 3'd5, 
	SHIFTR = 3'd6,
	SHIFTL = 3'd7;
	
	assign cbus_in = 	(alu_op == MOVA)? abus_out:
							(alu_op == MOVB)? bbus_out:
							(alu_op == ADD)? abus_out + bbus_out:
							(alu_op == SUB)? abus_out - bbus_out:
							(alu_op == MUL)? abus_out * bbus_out:
							(alu_op == DIV)? abus_out / bbus_out:
							(alu_op == SHIFTR)? abus_out >> 1:
							(alu_op == SHIFTL)? abus_out << 1:32'd0;
	assign z = ~|cbus_in;
	assign n = cbus_in[31];
	
endmodule

/*
module alu(	input [31:0] abus_out, bbus_out,
				input [2:0] alu_op,
				input clock, 
				output wire [31:0] cbus_in, 
				output wire n, z);
	
	reg [31:0] result = 0;
		
	parameter 
	MOVA = 3'd0,
	MOVB = 3'd1,
	ADD = 3'd2, 
	SUB = 3'd3, 
	MUL = 3'd4, 
	DIV = 3'd5, 
	SHIFTR = 3'd6,
	SHIFTL = 3'd7;
	
	always @(abus_out or bbus_out or alu_op)
		case (alu_op)
			MOVA: result <= abus_out;
			MOVB: result <= bbus_out;
			ADD: result <= abus_out + bbus_out; 
			SUB: result <= abus_out - bbus_out; 
			DIV: result <= abus_out / bbus_out; 
			MUL: result <= abus_out * bbus_out; 
			SHIFTR: result <= abus_out >> 1; 
			SHIFTL:result <= abus_out << 1;
			
			//default: result <= 0; 
		endcase
	
	assign z = ~|result;
	assign n = result[31]; 
	assign cbus_in = result; 
		
endmodule 
*/