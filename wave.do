onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/clock
add wave -noupdate /tb/LEDR
add wave -noupdate /tb/TP/cpu/ctrl/present
add wave -noupdate /tb/TP/mc1/status
add wave -noupdate /tb/TP/cpu/ma_r/inc_en
add wave -noupdate /tb/TP/cpu/ma_r/rst
add wave -noupdate /tb/TP/cpu/ma_r/abus_in
add wave -noupdate /tb/TP/cpu/pc_r/inc_en
add wave -noupdate /tb/TP/cpu/abus_out
add wave -noupdate /tb/TP/cpu/bbus_out
add wave -noupdate /tb/TP/cpu/alu_out
add wave -noupdate /tb/TP/cpu/reg1_out
add wave -noupdate /tb/TP/cpu/ir_r/data
add wave -noupdate /tb/TP/cpu/ma_r/data
add wave -noupdate /tb/TP/cpu/ac_r/data
add wave -noupdate /tb/TP/cpu/reg_1/data
add wave -noupdate /tb/TP/cpu/a_en
add wave -noupdate /tb/TP/cpu/b_en
add wave -noupdate /tb/TP/cpu/c_en
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 2} {1686 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 195
configure wave -valuecolwidth 39
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {1431 ps} {1937 ps}
