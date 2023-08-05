module test_module (
	input wire clk,
	input wire rst,

	input wire R_up,
	input wire G_up,
	input wire B_up,
	input wire R_down,
	input wire G_down,
	input wire B_down,


	output reg R_out,
	output reg G_out,
	output reg B_out
);

	reg [15:0] R_timer = 0;
	reg [15:0] G_timer = 0;
	reg [15:0] B_timer = 0;

	//27 Mhz clk
	reg [15:0] clk_timer = 0;

	//clk prescaler by 1024
	reg [9:0]	slow_clk = 0;
	always @(posedge clk)begin
		slow_clk = slow_clk + 1;
		clk_timer = clk_timer + 1;
	end

	always @(posedge rst) begin
		
	end

	//for comparison in waveform generation
	always @(posedge slow_clk[9]) begin
		if (!rst) begin
			R_timer = 0;
			G_timer = 0;
			B_timer = 0;
		end else begin

			if (R_up)
				if (R_timer != 'hffff)
					R_timer = R_timer + 1;
			if (!R_down)
				if (R_timer != 0)
					R_timer = R_timer - 1;

			if (G_up)
				if (G_timer != 'hffff)
					G_timer = G_timer + 1;
			if (!G_down)
				if (G_timer != 0)
					G_timer = G_timer - 1;
			
			if (B_up)
				if (B_timer != 'hffff)
					B_timer = B_timer + 1;
			if (!B_down)
				if (B_timer != 0)
					B_timer = B_timer - 1;
		end
		
	end
	
	//waveform comparison and generation
	always @(posedge clk) begin
		if (clk_timer < R_timer)
			R_out = 1;
		else
			R_out = 0;
		if (clk_timer < G_timer)
			G_out = 1;
		else
			G_out = 0;
		if (clk_timer < B_timer)
			B_out = 1;
		else
			B_out = 0;
	end



	

	


endmodule