create_clock -period 2.000 -name clk -waveform {0.000 1.000} [get_ports clk]

# Timing on rst input is not important as it is treated as asyncronous
set_false_path -from [get_ports rst]

# Allow output to arrive at destination "late" by one clock cycle as absolute timing is not important
set_output_delay -clock [get_clocks clk] -min -add_delay -2.200 [get_ports {data_out[*]}]
set_output_delay -clock [get_clocks clk] -max -add_delay -5.800 [get_ports {data_out[*]}]
