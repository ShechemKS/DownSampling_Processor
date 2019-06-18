module iram(	input clock, im_r,
					input [9:0] addr,
					output wire [31:0] instr_out);
	
	reg [31:0] memory [128:0];
	reg [31:0] current_instruction;
	
	initial begin
		$readmemb("Inst_mem.mem", memory);
	end
	
	always @(posedge clock) begin
	if (im_r==1)
		current_instruction <= memory[addr];
	else 
		current_instruction <= current_instruction;
	end
		
	assign instr_out = current_instruction;
	
endmodule	