// Decoder 

module decoder(   input [31:0] instruction,
						output reg [5:0] uAdr);
	
	/* decoder gets the instruction and passes the relevant starting state of each instruction to the controller*/
	
	wire [3:0] opcode = instruction[31:28];
	wire j_bit = instruction[27];
	wire n_bit = instruction[18];
	wire z_bit = instruction[17];
	wire constant = 1'b1; 
	
	wire j_logic, n_logic, z_logic; 
	
	and and_1(j_logic, constant, j_bit);
	and and_2(n_logic, constant, n_bit);
	and and_3(z_logic, constant, z_bit);
	
	parameter
	IDLE  = 4'd0,
	NOP 	= 4'd1,
	RSET 	= 4'd2,
	LOAD 	= 4'd3,
	STOR 	= 4'd4,
	MVAR 	= 4'd5,
	MVAO 	= 4'd6,
	MVAI 	= 4'd7,
	INC 	= 4'd8,
	ADD 	= 4'd9,
	SFTR 	= 4'd10,
	SFTL 	= 4'd11,
	JUMP 	= 4'd12,
	MUL 	= 4'd13,
	DIV 	= 4'd14,
	SUB 	= 4'd15;
	
	always @ (instruction)	// reads the instruction opcode and map it to the micro-instruction address 
		case(opcode)
			IDLE: uAdr = 6'd34;
			NOP: begin
				case (j_logic)
					1'b0: uAdr = 6'd3; 
					1'b1: uAdr = 6'd33;
					endcase
				end
				
			RSET: uAdr = 6'd4;
							
			LOAD: begin
				case (j_logic)
					1'b0: uAdr = 6'd5;
					1'b1: uAdr = 6'd7;
				endcase
				end
				
			STOR: begin
				case (j_logic)
					1'b0: uAdr = 6'd10;
					1'b1: uAdr = 6'd12;
				endcase
				end
				
			MVAR: begin
				case (j_logic)
					1'b0: uAdr = 6'd15;
					1'b1: uAdr = 6'd16;
				endcase
				end
				
			MVAO: uAdr = 6'd19;
								
			MVAI: begin
				case (j_logic)
					1'b0: uAdr = 6'd20;
					1'b1: uAdr = 6'd21;
				endcase
				end
				
			INC: uAdr = 6'd22;
								
			JUMP: begin
				case ({n_logic, z_logic})
					2'b00: uAdr = 6'd17;
					default: uAdr = 6'd18;
				endcase
				end
				
			ADD: begin
				case (j_logic)
					1'b0: uAdr = 6'd23;
					1'b1: uAdr = 6'd24;
				endcase
				end
				
			SUB: begin
				case (j_logic)
					1'b0: uAdr = 6'd25;
					1'b1: uAdr = 6'd26;
				endcase
				end
								
			MUL: begin
				case (j_logic)
					1'b0: uAdr = 6'd27;
					1'b1: uAdr = 6'd28;
				endcase
				end
								
			DIV: begin
				case (j_logic)
					1'b0: uAdr = 6'd29;
					1'b1: uAdr = 6'd30;
				endcase
				end
								
			SFTR: uAdr = 6'd31;
			SFTL: uAdr = 6'd32; 
			
			default: uAdr = 6'd0;
		endcase

endmodule 