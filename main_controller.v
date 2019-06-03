module main_control( input clock, en_com, 
							input end_receive,
							input end_process,
							input end_transmit, 
							input begin_process,
							input begin_transmit, 
							output reg [1:0] status,
							 
							output reg g1, g2, g3,
							output reg s0, s1, s2, s3);
							
			
	reg [1:0] p_stat ;
	reg [1:0] n_stat ;

	parameter 
	receive = 2'b00,
	process = 2'b01,
	transmit = 2'b10,
	finish = 2'b11;
	
	initial begin
		p_stat <= receive;
		n_stat <= receive;
		end
		
	always @(posedge clock)
	begin
		if (begin_process)
			g1 <= 1'b1;
		if (begin_transmit)
			g2 <= 1'b1;
		if (end_receive)
			g3 <= 1'b1; 
	end
	
	initial begin 
		g1 <= 1'b0;
		g2 <= 1'b0;
		g3 <= 1'b0;
		s0 <= 1'b0;
		s1 <= 1'b0; 
		s2 <= 1'b0;
		s3 <= 1'b0;
		//tx_en <= 1'b0;
	end
	
	always @(posedge clock)
		p_stat <= n_stat;
		
	always @(end_receive or end_process or end_transmit or begin_process or begin_transmit or p_stat or en_com)
		case (p_stat)
		
			receive: begin
				status <= 2'b00;
				s0 <= 1'b1;
				s1 <= 1'b0; 
				s2 <= 1'b0;
				s3 <= 1'b0;
				if (!end_process && !end_transmit && begin_process)
					
					n_stat <= process; //testing
				else
					n_stat <= receive;
				end
				
			process: begin
				status <= 2'b01;
				s0 <= 1'b1;
				s1 <= 1'b1; 
				s2 <= 1'b0;
				s3 <= 1'b0;
				//tx_en <= 1'b0;
				if (end_receive && end_process && !end_transmit)
					n_stat <= finish;
				else 
					n_stat <= process;
				end
				
			transmit: begin
				status <= 2'b10;
				s0 <= 1'b1;
				s1 <= 1'b1; 
				s2 <= 1'b1;
				s3 <= 1'b0;
				//tx_en <= 1'b1;
				if (end_receive  && end_transmit) //&& end_process
					n_stat <= finish;
				else 
					n_stat <= transmit;
				end
				
			finish: begin
				status <= 2'b11;
				s0 <= 1'b1;
				s1 <= 1'b1; 
				s2 <= 1'b1;
				s3 <= 1'b1;
				//tx_en <= 1'b0; 
				n_stat <= finish;
				end
				
			default: begin
				status <= 2'b00;
				s0 <= 1'b1;
				s1 <= 1'b0; 
				s2 <= 1'b0;
				s3 <= 1'b0;
				//tx_en <= 1'b0;
				n_stat <= receive;
				end
				
		endcase 
	
	



endmodule 