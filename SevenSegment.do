onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/ss/hexDigit
add wave -noupdate /testbench/ss/enable
add wave -noupdate /testbench/ss/segments
add wave -noupdate /testbench/ss/b0
add wave -noupdate /testbench/ss/b1
add wave -noupdate /testbench/ss/b2
add wave -noupdate /testbench/ss/b3
add wave -noupdate /testbench/ss/s
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 128
configure wave -valuecolwidth 68
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
WaveRestoreZoom {0 ps} {19295 ps}
