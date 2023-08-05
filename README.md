# RGB_LED PWM Generator
    RGB LED controlled through three PWM Signals using FPGA

## Digital Circuit
### Pinout
FPGA Board used in TANG PRIMER 20K.
    
Waveform generator module has the following pinout:

```verilog
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
```

clk used to synchronize circuit, used internal H11 pin of TANG PRIMER 20K
    
rst is logic low, used to reset all timers.

input pins X_up used to increase duty cycle.
X_up are logic high.

input pins X_down used to decrease duty cycle.
X_down are logic low.

the pwm singals are driven on the X_out.
### Timers

```verilog
reg [15:0] R_timer = 0;
reg [15:0] G_timer = 0;
reg [15:0] B_timer = 0;
reg [15:0] clk_timer = 0;
```

the X_timer registers are used for comparisons to decide current X_out pins level.
### Prescaler
```verilog
//clk prescaler by 1024
reg [9:0]	slow_clk = 0;
always @(posedge clk)begin
	slow_clk = slow_clk + 1;
	clk_timer = clk_timer + 1;
end
```
prescale the 27Mhz clk for user control.
### Set Timer Values
```verilog
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
```
increment, decrement, or reset timer registers on user input 
### Waveform Generation
```verilog
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
```
compare timer values and generate the waveform based on current timer values.

Higher X_timer values, means X pwm signal will have a larger duty cycle.


    