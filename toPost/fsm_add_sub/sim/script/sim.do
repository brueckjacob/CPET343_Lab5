vlib work
vcom -93 -work work ../../src/synchronizer_8bit.vhd
vcom -93 -work work ../../src/rising_edge_synchronizer.vhd
vcom -93 -work work ../../src/bin_to_bcd.vhd
vcom -93 -work work ../../src/fsm_controller.vhd
vcom -93 -work work ../../src/add_sub.vhd
vcom -93 -work work ../../src/seven_seg.vhd
vcom -93 -work work ../src/add_sub_tb.vhd
vsim -voptargs="+acc" -msgmode both add_sub_tb
do wave.do
run 6 us