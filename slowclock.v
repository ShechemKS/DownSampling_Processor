module slowclock(inclk,switch_clock,outclk);
	parameter max = 25'd500;
	input inclk;
	input [1:0] switch_clock;
	output reg outclk = 0;
	
	reg [24:0] count = 0;
	
	always @(posedge inclk)
		begin
			if (switch_clock == 2'b01)
				begin
					if (count == max)
						begin
							outclk = ~outclk;
							count = 0;
						end
					else
						begin
							count = count+1;
						end
				end
			else
				begin
					outclk = ~outclk;
				end	
		end
	
endmodule 