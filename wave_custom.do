onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /ece_270_lab_code_tb/clk
add wave -noupdate -color Gray90 -label DIP_SWITCH -radix symbolic -radixshowbase 0 /ece_270_lab_code_tb/uut/DIP
add wave -noupdate -group {SPDT pushbuttons} /ece_270_lab_code_tb/uut/S1_NC
add wave -noupdate -group {SPDT pushbuttons} /ece_270_lab_code_tb/uut/S1_NO
add wave -noupdate -group {SPDT pushbuttons} /ece_270_lab_code_tb/uut/S2_NC
add wave -noupdate -group {SPDT pushbuttons} /ece_270_lab_code_tb/uut/S2_NO
add wave -noupdate -color Magenta -radix symbolic -radixshowbase 0 /ece_270_lab_code_tb/uut/TOPRED
add wave -noupdate -color Magenta -radix symbolic -radixshowbase 0 /ece_270_lab_code_tb/uut/MIDRED
add wave -noupdate -color Magenta -radix symbolic -radixshowbase 0 /ece_270_lab_code_tb/uut/BOTRED
add wave -noupdate -group {L-R yellow LEDs} -color Khaki -radix symbolic -radixshowbase 0 /ece_270_lab_code_tb/uut/LED_YELLOW_L
add wave -noupdate -group {L-R yellow LEDs} -color Khaki -radix symbolic -radixshowbase 0 /ece_270_lab_code_tb/uut/LED_YELLOW_R
add wave -noupdate -expand -group {7-seg displays} -color Pink -radix ascii -radixshowbase 0 /ece_270_lab_code_tb/uut/DIS4
add wave -noupdate -expand -group {7-seg displays} -color Pink -radix ascii -radixshowbase 0 /ece_270_lab_code_tb/uut/DIS3
add wave -noupdate -expand -group {7-seg displays} -color Pink -radix ascii -radixshowbase 0 /ece_270_lab_code_tb/uut/DIS2
add wave -noupdate -expand -group {7-seg displays} -color Pink -radix ascii -radixshowbase 0 /ece_270_lab_code_tb/uut/DIS1
add wave -noupdate -expand -group {jumbo LEDs} -color {Indian Red} -radix symbolic -radixshowbase 0 /ece_270_lab_code_tb/uut/JUMBO_R
add wave -noupdate -expand -group {jumbo LEDs} -color Yellow -radix symbolic -radixshowbase 0 /ece_270_lab_code_tb/uut/JUMBO_Y
add wave -noupdate -expand -group {jumbo LEDs} -color Green -radix symbolic -radixshowbase 0 /ece_270_lab_code_tb/uut/JUMBO_G
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {500 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 133
configure wave -valuecolwidth 70
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 10
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {1673 ns}
