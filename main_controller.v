// Main Controller 

module main_control( input clock,
							input end_process,
							input start_process,
							output reg [1:0] status,
							output reg s0, s1, s2, s3);
							
			
	reg [1:0] p_stat ;
	reg [1:0] n_stat ;

	parameter 
	receive = 2'b00,
	process = 2'b01,
	finish = 2'b10;
	
	initial begin
		p_stat <= receive;
		n_stat <= receive;
		end
		
	initial begin 
		s0 <= 1'b0;
		s1 <= 1'b0; 
		s2 <= 1'b0;
		s3 <= 1'b0;
	end
	
	always @(posedge clock)
		p_stat <= n_stat;
		
	always @(end_process or start_process)
		case (p_stat)
		
			receive: begin
				status <= 2'b00;
				s0 <= 1'b1;
				s1 <= 1'b0; 
				s2 <= 1'b0;
				s3 <= 1'b0;
				if (start_process)
					n_stat <= process; 
				else
					n_stat <= receive;
				end
				
			process: begin
				status <= 2'b01;
				s0 <= 1'b1;
				s1 <= 1'b1; 
				s2 <= 1'b0;
				s3 <= 1'b0;
				
				if (end_process)
					n_stat <= finish;
				
				else
					n_stat <= process;
				end

				
			finish: begin
				status <= 2'b10;
				s0 <= 1'b1;
				s1 <= 1'b1; 
				s2 <= 1'b1;
				s3 <= 1'b0;
				
				n_stat <= finish;
				end
			
				
			default: begin
				status <= 2'b00;
				s0 <= 1'b1;
				s1 <= 1'b0; 
				s2 <= 1'b0;
				s3 <= 1'b0;
				n_stat <= receive;
				end
				
		endcase 
	
	



endmodule 