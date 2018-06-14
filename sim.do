#########################################
## Filename: 		"sim.do" 			#
## Written by:		Andrew St. Pierre	#
## Last modified:	June 13, 2018	 	#
## Function:		sim script for tb	#
#########################################

# compile files
do compile.do

# start simulation
vsim -gui -novopt work.ece_270_lab_code_tb

# open waveform
do wave_custom.do

# run sim (in ns)
run 500