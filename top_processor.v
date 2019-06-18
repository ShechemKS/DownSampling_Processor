module top_processor(	input wire clock, 				
								input wire data_from_pc, 		 
								input wire start_process, 
								input wire start_transmit,
								input wire rx,rd_clr,
								//output wire rd_rx,
								//output wire tx, tx_busy,
								output [17:0] mar_ac_disp,
								
								//output endImagereceived,
								//output endProcess,	
								//output wire data_to_pc, 			
								//output wire g1, g2, g3,
								//output wire s00, s01, s02, s03,
								output clk,
								output [7:0] pc_disp);
	
	
		
	// For processor 
	
	
	wire [19:0] cm_out;						
	wire [7:0] dm_processor;				
	wire [31:0] im_out;						
	wire [1:0] status;						
	wire dm_r, dm_wr, cm_r, im_r;			
	wire [7:0] ac_out;						
	wire [9:0] pc_out;
	wire [17:0] c;
	wire [2:0] mar_cm;						
	wire [19:0] mar_dm;						
	wire end_process;
	wire slow_clk;
	wire e;
	
	assign clk = clock;
	assign mar_ac_disp = c;
	assign pc_disp= pc_out;
	
	assign endProcess = end_process;	
					 
	// Main Controller

	wire end_receive, end_transmit;		// signals to be given by the communication module to change the state
	reg begin_process, begin_transmit; 	// should be assigned 
	
	assign endImagereceived = end_receive ;
	
	// Memory DRAM
	
	wire [7:0] data_in_com; 				// data to the com module to be transmitted 
	wire [7:0] dm_in;							// data to the dram
	wire [7:0] dm_out;
	
	// Muxes
	wire [19:0] tx_dm;						// address from transmitter module to write
	wire [19:0] dm_addr;						// data memory address ( from processor or from tx_addr)
	
	wire [19:0] rx_dm;
	
	// Tx and Rx
	wire [7:0] dm_transmitter; 
	wire tx_en; 
	wire tx_clk_en, rx_clk_en;
	//wire tx, tx_busy; 
	wire [7:0] tx_data;
	wire [7:0] data_out_rx;					// data from receiver module 
	wire en_com;								// to enable the communication
	
	//assign end_trasnmit = ~tx_busy; 
	 
	
	reg [9:0] process_switch_buffer = 10'd1001;		// waits 1023 clock cycles until the begin_process is being passed to main controller
	reg [9:0] transmit_switch_buffer = 10'd0;		// waits 1023 clock cycles until the transmit_begin is being passed to main controller

	always @(posedge clock)
	begin
		if (start_process )
		begin
			if (process_switch_buffer == 10'd1023 )
			begin
				process_switch_buffer <= process_switch_buffer ;
				begin_process <=1;
			end
			else
			begin
				process_switch_buffer <= process_switch_buffer + 10'd1;
				begin_process <=0;
			end
		end
		else
		begin
			process_switch_buffer <= 10'd1001;
			begin_process <= 0;
		end
	end

	always @(posedge clock)
	begin
		
		if (start_transmit )
		begin
			if (transmit_switch_buffer == 10'd1023 )
			begin
				transmit_switch_buffer <= transmit_switch_buffer ;
				begin_transmit <=1;
			end
			else
			begin
				transmit_switch_buffer <= transmit_switch_buffer + 10'd1;
				begin_transmit <=0;
			end
		end
		else
		begin
			transmit_switch_buffer <= 10'd0;
			begin_transmit <= 0;
		end
	end
	

/*
	cram 			cram1(	.clock(slow_clk), 
								.cm_r(cm_r), 
								.cm_addr(mar_cm), 
								.cm_out(cm_out)); 
*/
	C_ram 		cram1(.address(mar_cm),
							.clock(clock),
							.rden(cm_r),
							.q(cm_out));				
	iram  		iram1(	.clock(clock), 
								.im_r(im_r), 
								.addr(pc_out), 
								.instr_out(im_out)); 
					
	Processor 	cpu (		.clock(clock), 
								.cm_out(cm_out), 
								.dm_out(dm_processor), 
								.im_out(im_out), 
								.status(status), 
								.dm_r(dm_r), 
								.im_r(im_r), 
								.cm_r(cm_r), 
								.dm_wr(dm_wr), 
								.dm_in(ac_out), 
								.pc_out(pc_out), 
								.mar_dm(mar_dm), 
								.mar_cm(mar_cm),
								.end_process(end_process),
								.c(c));
								
	dram	d_ram( 	.address(mar_dm),
						.clock(clock),
						.data(ac_out),
						.wren(dm_wr),
						.rden(dm_r), 
						.q(dm_processor));					

	main_control mc1(		.clock(clock), 
								.en_com(en_com),
								.end_receive(end_receive), 
								.end_process(end_process), 
								.end_transmit(end_transmit), 
								.begin_process(begin_process), 
								.begin_transmit(begin_transmit), 
								.status(status), 
								.g1(g1), .g2(g2), .g3(g3), 
								.s0(s00), .s1(s01), .s2(s02), .s3(s03)); 
			
	slowclock clk1 (	.inclk(clock),
							.outclk(slow_clk),
							.switch_clock(status));

					
endmodule 	
	
