// control unit  

module controller(	input clock, n, z,
							input [5:0] uAdr,
							input [1:0] status, 
							input [31:0] instruction, 
							output reg [2:0] alu_op, abus_en, bbus_en, 
							output reg [3:0] cbus_en, mem_en,
							output reg [4:0] inc_en,
							output reg [5:0] reset,
							output reg end_process);
							

	reg [5:0] present;
	reg [5:0] next;
	
	reg N, Z, uI; // these are not output from controller as these are not used for any external logic from controller
	
	parameter
	FETCH1 	= 	6'd0,
	FETCHX 	= 	6'd1,
	FETCH2 	= 	6'd2,
	NOP 		= 	6'd3,
	RSET 		= 	6'd4,
	LOADR1 	= 	6'd5,
	LOADR2 	= 	6'd6, 
	LOADK1 	= 	6'd7,
	LOADK2 	= 	6'd8,
	LOADK3 	= 	6'd9,
	STORR1 	= 	6'd10,
	STORR2 	= 	6'd11,
	STORK1 	= 	6'd12,
	STORK2 	= 	6'd13,
	STORK3 	= 	6'd14,
	MVARS 	= 	6'd15,
	MVARD 	= 	6'd16, 
	JUMP 		= 	6'd17,
	JMPX 		= 	6'd18,
	MVACO 	= 	6'd19,
	MVACA 	= 	6'd20,
	MVACB 	= 	6'd21,
	INC 		= 	6'd22,
	ADDK 		= 	6'd23,
	ADDR 		= 	6'd24,
	SUBK 		= 	6'd25,
	SUBR 		= 	6'd26,
	MULK 		= 	6'd27,
	MULR 		= 	6'd28,
	DIVK 		= 	6'd29,
	DIVR 		= 	6'd30,
	SHFR 		= 	6'd31,
	SFTL 		= 	6'd32,
	END 		= 	6'd33,
	IDLE 		= 	6'd34,
	JMPXX		=  6'd35,
	BEGIN		=	6'd36,
	LOADR3	=	6'd37,
	LOADK4	=	6'd38,
	STORR3	=	6'd39,
	STORK4	=	6'd40;
	
	initial begin
		present <= IDLE;
		next <= IDLE;
	end
	
	always @ (negedge clock)
		present <= next;
		
	always @(posedge clock)
		begin
			if (present == END)
				end_process <= 1'd1;
			else
				end_process <= 1'd0;
		end

	always @ (posedge clock)
		case (present)
		
			IDLE: begin
				reset <= 6'b111111;
				mem_en <= 4'b0000;
				inc_en <= 5'b00000;
				alu_op <= 3'd0;
				N <= 0;
				Z <= 0;
				abus_en <= 3'd0;
				bbus_en <= 3'd0;
				cbus_en <= 4'd0;
				uI <= 0;
				if (status == 2'b01)
					next <= FETCH1;
				else 
					next <= IDLE;
				end 
		
			BEGIN: begin
				reset <= 6'b000000;
				mem_en <= 4'b0000;
				inc_en <= 5'b00000;
				alu_op <= 3'd0;
				N <= 0;
				Z <= 0;
				abus_en <= 3'd0;
				bbus_en <= 3'd0;
				cbus_en <= 4'd0;
				uI <= 0;
				if (status == 2'b01)
					next <= IDLE;
				else 
					next <= BEGIN;
				end 
				
			FETCH1: begin 
				reset <= 6'b000000;
				mem_en <= 4'b1000;
				inc_en <= 5'b00000;
				alu_op <= 3'd0;
				N <= 0;
				Z <= 0;
				abus_en <= 3'd0;
				bbus_en <= 3'd0;
				cbus_en <= 4'd0;
				uI <= 1;
				next <= FETCHX;
				end 
			
			FETCHX: begin
				reset <= 6'b000000;
				mem_en <= 4'b1000;
				inc_en <= 5'b00000;
				alu_op <= 3'd0;
				N <= 0;
				Z <= 0;
				abus_en <= 3'd0;
				bbus_en <= 3'd0;
				cbus_en <= 4'd0;
				uI <= 1;
				next <= FETCH2;
				end
			
			FETCH2: begin
				reset <= 6'b000000;
				mem_en <= 4'b1000;
				inc_en <= 5'b00001;
				alu_op <= 3'd0;
				N <= 0;
				Z <= 0;
				abus_en <= 3'd0;
				bbus_en <= 3'd0;
				cbus_en <= 4'd0;
				uI <= 0;
				next <= uAdr;
				end
				
			NOP: begin
				reset <= 6'b000000;
				mem_en <= 4'b0000;
				inc_en <= 5'b00000;
				alu_op <= 3'd0;
				N <= 0;
				Z <= 0;
				abus_en <= 3'd0;
				bbus_en <= 3'd0;
				cbus_en <= 4'd0;
				uI <= 0;
				next <= FETCH1;
				end
					
			RSET: begin
				reset [4:0]<= instruction[26:22];
				reset[5] <= 1'b0;
				mem_en <= 4'b0000;
				inc_en <= 5'b00000;
				alu_op <= 3'd0;
				N <= 0;
				Z <= 0;
				abus_en <= 3'd0;
				bbus_en <= 3'd0;
				cbus_en <= 4'd0;
				uI <= 0;
				next <= FETCH1;
				end
			
			LOADR1: begin
				reset <= 6'b000000;
				mem_en <= 4'b0010;
				inc_en <= 5'b00000;
				alu_op <= 3'd0;
				N <= 0;
				Z <= 0;
				abus_en <= 3'd0;
				bbus_en <= 3'd0;
				cbus_en <= 4'd0;
				uI <= 1;
				
				//if (uI == 1)
					next <= LOADR2; 
				end
			
			LOADR2: begin
				reset <= 6'b000000;
				mem_en <= 4'b0010;
				inc_en <= 5'b00000;
				alu_op <= 3'd0;
				N <= 0;
				Z <= 0;
				abus_en <= 3'd0;
				bbus_en <= 3'd0;
				cbus_en <= 4'd0;
				uI <= 1;
				
				//if (uI == 1)
					next <= LOADR3; 
				end
				
			LOADR3: begin
				reset <= 6'b000000;
				mem_en <= 4'b0010;
				inc_en <= 5'b00000;
				alu_op <= 3'd0;
				N <= 0;
				Z <= 0;
				abus_en <= 3'd0;
				bbus_en <= 3'd0;
				cbus_en <= 4'd0;
				uI <= 0;
				
				//if (uI == 0)
					next <= FETCH1 ;
				end 
			
			LOADK1: begin
				reset <= 6'b000000;
				mem_en <= 4'b0000;
				inc_en <= 5'b00000;
				alu_op <= 3'd0;
				N <= 0;
				Z <= 0;
				abus_en <= 3'd7;
				bbus_en <= 3'd0;
				cbus_en <= 4'd12;
				uI <= 1;
				
				//if (uI ==1)
					next <= 	LOADK2; 
				end 
				
			LOADK2: begin
				reset <= 6'b000000;
				mem_en <= 4'b0100;
				inc_en <= 5'b00000;
				alu_op <= 3'd0;
				N <= 0;
				Z <= 0;
				abus_en <= 3'd0;
				bbus_en <= 3'd0;
				cbus_en <= 4'd0;
				uI <= 1;
				
				//if (uI == 1)
					next <= LOADK3;
				end 
				
			LOADK3: begin
				reset <= 6'b000000;
				mem_en <= 4'b0100;
				inc_en <= 5'b00000;
				alu_op <= 3'd0;
				N <= 0;
				Z <= 0;
				abus_en <= 3'd0;
				bbus_en <= 3'd0;
				cbus_en <= 4'd0;
				uI <= 1;
				
				//if (uI == 1)
					next <= LOADK4;
				end 
				
			LOADK4: begin
				reset <= 6'b000000;
				mem_en <= 4'b0100;
				inc_en <= 5'b00000;
				alu_op <= 3'd0;
				N <= 0;
				Z <= 0;
				abus_en <= 3'd0;
				bbus_en <= 3'd0;
				cbus_en <= 4'd0;
				uI <= 0;
				
				//if (uI == 0)
				next <= FETCH1;
				end 
				
			STORR1: begin
				reset <= 6'b000000;
				mem_en <= 4'b0001;
				inc_en <= 5'b00000;
				alu_op <= 3'd0;
				N <= 0;
				Z <= 0;
				abus_en <= 3'd0;
				bbus_en <= 3'd0;
				cbus_en <= 4'd0;
				uI <= 1;
				
				//if (uI == 1)
					next <= STORR2;
				end 
			
			STORR2: begin
				reset <= 6'b000000;
				mem_en <= 4'b0001;
				inc_en <= 5'b00000;
				alu_op <= 3'd0;
				N <= 0;
				Z <= 0;
				abus_en <= 3'd0;
				bbus_en <= 3'd0;
				cbus_en <= 4'd0;
				uI <= 1;
				
				//if (uI == 1)
					next <= STORR3;
				end 
				
			STORR3: begin
				reset <= 6'b000000;
				mem_en <= 4'b0001;
				inc_en <= 5'b00000;
				alu_op <= 3'd0;
				N <= 0;
				Z <= 0;
				abus_en <= 3'd0;
				bbus_en <= 3'd0;
				cbus_en <= 4'd0;
				uI <= 0;
				
				//if (uI == 0)
					next <= FETCH1;
				end 
				
			STORK1: begin
				reset <= 6'b000000;
				mem_en <= 4'b0000;
				inc_en <= 5'b00000;
				alu_op <= 3'd0;
				N <= 0;
				Z <= 0;
				abus_en <= 3'd7;
				bbus_en <= 3'd0;
				cbus_en <= 4'd12;
				uI <= 1;
				
				//if (uI == 1)
					next <= STORK2;
				end 
			
			STORK2: 	begin
				reset <= 6'b000000;
				mem_en <= 4'b0001;
				inc_en <= 5'b00000;
				alu_op <= 3'd0;
				N <= 0;
				Z <= 0;
				abus_en <= 3'd0;
				bbus_en <= 3'd0;
				cbus_en <= 4'd0;
				uI <= 1;
				
				//if (uI == 1)
					next <= STORK3;
				end 
			
			STORK3: 	begin
				reset <= 6'b000000;
				mem_en <= 4'b0001;
				inc_en <= 5'b00000;
				alu_op <= 3'd0;
				N <= 0;
				Z <= 0;
				abus_en <= 3'd0;
				bbus_en <= 3'd0;
				cbus_en <= 4'd0;
				uI <= 1;
				
				//if (uI == 1)
					next <= STORK4;
				end 
				
			STORK4: begin
				reset <= 6'b000000;
				mem_en <= 4'b0001;
				inc_en <= 5'b00000;
				alu_op <= 3'd0;
				N <= 0;
				Z <= 0;
				abus_en <= 3'd0;
				bbus_en <= 3'd0;
				cbus_en <= 4'd0;
				uI <= 0;
				
				//if (uI == 0)
					next <= FETCH1;
				end 
				
			MVARS: begin
				reset <= 6'b000000;
				mem_en <= 4'b0000;
				inc_en <= 5'b00000;
				alu_op <= 3'd0;
				N <= 0;
				Z <= 0;
				abus_en <= 3'd1;
				bbus_en <= 3'd0;
				cbus_en <= 4'd12;
				uI <= 0;
				
				//if (uI == 0)
					next <= FETCH1;
				end 
				
			MVARD: begin
				reset <= 6'b000000;
				mem_en <= 4'b0000;
				inc_en <= 5'b00000;
				alu_op <= 3'd0;
				N <= 0;
				Z <= 0;
				abus_en <= 3'd2;
				bbus_en <= 3'd0;
				cbus_en <= 4'd12;
				uI <= 0;
				
				//if (uI == 0)
					next <= FETCH1;
				end
				
			JUMP: begin
				reset <= 6'b000000;
				mem_en <= 4'b0000;
				inc_en <= 5'b00000;
				alu_op <= 3'd0;
				N <= 0;
				Z <= 0;
				abus_en <= 3'd7;
				bbus_en <= 3'd0;
				cbus_en <= 4'd14;
				uI <= 0;
				
				//if (uI == 0)
					next <= FETCH1;
				end 
				
			JMPX: begin
				reset <= 6'b000000;
				mem_en <= 4'b0000;
				inc_en <= 5'b00000;
				alu_op <= 3'd3;
				N <= instruction[18];
				Z <= instruction[17];
				abus_en <= instruction[25:23];
				bbus_en <= instruction[21:19];
				cbus_en <= 4'd0;
				uI <= 1;
				
				//if (uI == 1)
					next <= JMPXX; 
				end 
				
			JMPXX: begin
				reset <= 6'b000000;
				mem_en <= 4'b0000;
				inc_en <= 5'b00000;
				alu_op <= 3'd3;
				N <= instruction[18];
				Z <= instruction[17];
				abus_en <= instruction[25:23];
				bbus_en <= instruction[21:19];
				cbus_en <= 4'd0;
				uI <= 1;
			
				if ((uI == 1) && (N == 1) && (n == 1))
					next <= JUMP;
				
				else if ((uI ==1) && (Z == 1) && (z == 1))
					next <= JUMP;
				
				else
					next <= FETCH1;
				end 
				
			MVACO: begin
				reset <= 6'b000000;
				mem_en <= 4'b0000;
				inc_en <= 5'b00000;
				alu_op <= 3'd0;
				N <= 0;
				Z <= 0;
				abus_en <= 3'd3;
				bbus_en <= 3'd0;
				cbus_en <= instruction[26:23];
				uI <= 0;
				
				//if (uI == 0)
					next <= FETCH1;
				end 
				
			MVACA: begin
				reset <= 6'b000000;
				mem_en <= 4'b0000;
				inc_en <= 5'b00000;
				alu_op <= 3'd0;
				N <= 0;
				Z <= 0;
				abus_en <= instruction[25:23];
				bbus_en <= 3'd0;
				cbus_en <= 4'd11;
				uI <= 0;
				
				//if (uI == 0)
					next <= FETCH1;
				end 
				
			MVACB: begin
				reset <= 6'b000000;
				mem_en <= 4'b0000;
				inc_en <= 5'b00000;
				alu_op <= 3'd1;
				N <= 0;
				Z <= 0;
				abus_en <= 3'd0;
				bbus_en <= instruction[25:23];
				cbus_en <= 4'd11;
				uI <= 0;
				
				//if (uI == 0)
					next <= FETCH1;
				end 
				
			INC: begin
				reset <= 6'b000000;
				mem_en <= 4'b0000;
				inc_en[4:1] <= instruction[26:23];
				inc_en[0]<=1'b0;
				alu_op <= 3'd0;
				N <= 0;
				Z <= 0;
				abus_en <= 3'd0;
				bbus_en <= 3'd0;
				cbus_en <= 4'd0;
				uI <= 0;
				
				//if (uI == 0)
					next <= FETCH1;
				end 
				
			ADDK: begin
				reset <= 6'b000000;
				mem_en <= 4'b0000;
				inc_en <= 5'b00000;
				alu_op <= 3'd2;
				N <= 0;
				Z <= 0;
				abus_en <= instruction[25:23];
				bbus_en <= 3'd7;
				cbus_en <= instruction[26:23];
				uI <= 0;
				
				//if (uI == 0)
					next <= FETCH1;
				end 
				
			ADDR: begin
				reset <= 6'b000000;
				mem_en <= 4'b0000;
				inc_en <= 5'b00000;
				alu_op <= 3'd2;
				N <= 0;
				Z <= 0;
				abus_en <= instruction[25:23];
				bbus_en <= instruction[21:19];
				cbus_en <= instruction[26:23];
				uI <= 0;
				
				//if (uI == 0)
					next <= FETCH1;
				end 
				
			SUBK: begin
				reset <= 6'b000000;
				mem_en <= 4'b0000;
				inc_en <= 5'b00000;
				alu_op <= 3'd3;
				N <= 0;
				Z <= 0;
				abus_en <= instruction[25:23];
				bbus_en <= 3'd7;
				cbus_en <= instruction[26:23];
				uI <= 0;
				
				if (uI == 0)
					next <= FETCH1;
				end 
				
			SUBR: begin
				reset <= 6'b000000;
				mem_en <= 4'b0000;
				inc_en <= 5'b00000;
				alu_op <= 3'd3;
				N <= 0;
				Z <= 0;
				abus_en <= instruction[25:23];
				bbus_en <= instruction[21:19];
				cbus_en <= instruction[26:23];
				uI <= 0;
				
				if (uI == 0)
					next <= FETCH1;
				end 
				
			MULK: begin
				reset <= 6'b000000;
				mem_en <= 4'b0000;
				inc_en <= 5'b00000;
				alu_op <= 3'd4;
				N <= 0;
				Z <= 0;
				abus_en <= instruction[25:23];
				bbus_en <= 3'd7;
				cbus_en <= instruction[26:23];
				uI <= 0;
				
				if (uI == 0)
					next <= FETCH1;
				end 
			
			MULR: begin
				reset <= 6'b000000;
				mem_en <= 4'b0000;
				inc_en <= 5'b00000;
				alu_op <= 3'd4;
				N <= 0;
				Z <= 0;
				abus_en <= instruction[25:23];
				bbus_en <= instruction[21:19];
				cbus_en <= instruction[26:23];
				uI <= 0;
				
				if (uI == 0)
					next <= FETCH1;
				end 
			
			DIVK: begin
				reset <= 6'b000000;
				mem_en <= 4'b0000;
				inc_en <= 5'b00000;
				alu_op <= 3'd5;
				N <= 0;
				Z <= 0;
				abus_en <= instruction[25:23];
				bbus_en <= 3'd7;
				cbus_en <= instruction[26:23];
				uI <= 0;
				
				if (uI == 0)
					next <= FETCH1;
				end 
			
			DIVR: begin
				reset <= 6'b000000;
				mem_en <= 4'b0000;
				inc_en <= 5'b00000;
				alu_op <= 3'd5;
				N <= 0;
				Z <= 0;
				abus_en <= instruction[25:23];
				bbus_en <= instruction[21:19];
				cbus_en <= instruction[26:23];
				uI <= 0;
				
				if (uI == 0)
					next <= FETCH1;
				end 
			
			SHFR: begin
				reset <= 6'b000000;
				mem_en <= 4'b0000;
				inc_en <= 5'b00000;
				alu_op <= 3'd6;
				N <= 0;
				Z <= 0;
				abus_en <= 3'd3;
				bbus_en <= 3'd0;
				cbus_en <= 4'd11;
				uI <= 0;
				
				if (uI == 0)
					next <= FETCH1;
				end 
			
			SFTL: begin
				reset <= 6'b000000;
				mem_en <= 4'b0000;
				inc_en <= 5'b00000;
				alu_op <= 3'd7;
				N <= 0;
				Z <= 0;
				abus_en <= 3'd3;
				bbus_en <= 3'd0;
				cbus_en <= 4'd11;
				uI <= 0;
				
				if (uI == 0)
					next <= FETCH1;
				end 
				
			END: begin
				reset <= 6'b111111;
				mem_en <= 4'b0000;
				inc_en <= 5'b00000;
				alu_op <= 3'd0;
				N <= 0;
				Z <= 0;
				abus_en <= 3'd0;
				bbus_en <= 3'd0;
				cbus_en <= 4'd0;
				uI <= 0;
				next <= END; 
				end

			default: begin
				reset <= 6'b000000;
				mem_en <= 4'b0000;
				inc_en <= 5'b00000;
				alu_op <= 3'd0;
				N <= 0;
				Z <= 0;
				abus_en <= 3'd0;
				bbus_en <= 3'd0;
				cbus_en <= 4'd0;
				uI <= 0;
				next <= IDLE;
				end 
		endcase

endmodule 