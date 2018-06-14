#########################################
## Filename: 		"compile.do"		#
## Written by:		Andrew St. Pierre	#
## Last modified:	June 13, 2018	 	#
## Function:		compile script		#
#########################################

# ensure we make a clean working directory for each pass of the script
vdel -all -lib work
vlib work
vmap work work

# files to compile
vlog ece_270_lab_code.v 
vlog ece_270_lab_code_tb.v