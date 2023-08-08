
# Entity: test_module 
- **File**: top.v

## Diagram
![Diagram](test_module.svg "Diagram")
## Ports

| Port name | Direction | Type | Description |
| --------- | --------- | ---- | ----------- |
| clk       | input     | wire |     sync        |
| rst       | input     | wire |     sync reset      |
| R_up      | input     | wire | inc red duty     |
| G_up      | input     | wire |        inc green duty    |
| B_up      | input     | wire |      inc blue duty       |
| R_down    | input     | wire |   dec red duty           |
| G_down    | input     | wire |   dec green duty         |
| B_down    | input     | wire |   dec blue duty         |
| R_out     | output    | reg  |   red PWM Signal pin          |
| G_out     | output    | reg  |   green PWM Signal pin         |
| B_out     | output    | reg  |   blue PWM Signal Pin          |

## Signals

| Name          | Type       | Description |
| ------------- | ---------- | ----------- |
| R_timer = 0   | reg [15:0] | red's current duty            |
| G_timer = 0   | reg [15:0] | green's current duty            |
| B_timer = 0   | reg [15:0] | blue's current duty            |
| clk_timer = 0 | reg [15:0] | used for comparison            |
| slow_clk = 0  | reg [9:0]  | used for superscaling            |
