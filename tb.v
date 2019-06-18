//`timescale  100 ps/1 ps

module tb;
	reg clock = 0; 
	reg data_from_pc, start_process, start_transmit, rx,rd_clr;
	wire rd_rx, tx, tx_busy, endImagereceived,endProcess,	data_to_pc,g1, g2, g3,s0, s1, s2, s3;
	wire [7:0] LEDR;
	//top_processor TP (clock, data_from_pc, start_process, start_transmit,rx,rd_clr,rd_rx,tx, tx_busy,LEDR,endImagereceived,endProcess,data_to_pc, g1, g2, g3,s0, s1, s2, s3,clk);
								
	always begin
	#50 clock = ~clock;
	end
	
	
	initial
		begin 
			$monitor("pc = %b ",LEDR);
			#100000 $finish;
			
		end
endmodule
	