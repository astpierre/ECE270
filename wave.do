onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 20 -expand -group {ECE270 LAB PLD BREAKOUT BOARD} /ece_270_lab_code_tb/TOPRED
add wave -noupdate -height 20 -expand -group {ECE270 LAB PLD BREAKOUT BOARD} /ece_270_lab_code_tb/uut/TOPRED
add wave -noupdate /ece_270_lab_code_tb/uut/o_TOPRED
add wave -noupdate -radix binary /ece_270_lab_code_tb/uut/DIP
add wave -noupdate /ece_270_lab_code_tb/uut/i_S1_NC
add wave -noupdate /ece_270_lab_code_tb/uut/i_S1_NO
add wave -noupdate /ece_270_lab_code_tb/uut/i_S2_NC
add wave -noupdate /ece_270_lab_code_tb/uut/i_S2_NO
add wave -noupdate /ece_270_lab_code_tb/uut/o_MIDRED
add wave -noupdate /ece_270_lab_code_tb/uut/o_BOTRED
add wave -noupdate /ece_270_lab_code_tb/uut/o_DIS1
add wave -noupdate /ece_270_lab_code_tb/uut/o_DIS2
add wave -noupdate /ece_270_lab_code_tb/uut/o_DIS3
add wave -noupdate /ece_270_lab_code_tb/uut/o_DIS4
add wave -noupdate /ece_270_lab_code_tb/uut/o_JUMBO
add wave -noupdate /ece_270_lab_code_tb/uut/o_LED_YELLOW
add wave -noupdate /ece_270_lab_code_tb/uut/S1_NC
add wave -noupdate /ece_270_lab_code_tb/uut/S1_NO
add wave -noupdate /ece_270_lab_code_tb/uut/S2_NC
add wave -noupdate /ece_270_lab_code_tb/uut/S2_NO
add wave -noupdate /ece_270_lab_code_tb/uut/TOPRED
add wave -noupdate /ece_270_lab_code_tb/uut/MIDRED
add wave -noupdate -radix ascii -radixshowbase 0 /ece_270_lab_code_tb/uut/BOTRED
add wave -noupdate /ece_270_lab_code_tb/uut/DIS1
add wave -noupdate /ece_270_lab_code_tb/uut/DIS2
add wave -noupdate /ece_270_lab_code_tb/uut/DIS3
add wave -noupdate /ece_270_lab_code_tb/uut/DIS4
add wave -noupdate /ece_270_lab_code_tb/uut/JUMBO_unused
add wave -noupdate /ece_270_lab_code_tb/uut/JUMBO_R
add wave -noupdate /ece_270_lab_code_tb/uut/JUMBO_Y
add wave -noupdate /ece_270_lab_code_tb/uut/JUMBO_G
add wave -noupdate /ece_270_lab_code_tb/uut/LED_YELLOW_L
add wave -noupdate /ece_270_lab_code_tb/uut/LED_YELLOW_R
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {250 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 70
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {4055 ns}
