#!/bin/bash

###########################################################################
# This program takes the LAMMPS output log to search and find the snippet
# where the thermodynamic information is located to copy and paste it 
# into a new file, so its easier to plot.
# It requires two arguments:
# arg1: the name of the file to read
# arg2: the name of the file to write into
# Example: ./script_output.sh log.lammps output.dat
##########################################################################

filt1=$(grep -n "Step Time" $1 | cut -d : -f 1)
filt2=$(grep -n "Loop time" $1 | cut -d : -f 1)
cat $1 | awk "NR>=$filt1 && NR<$filt2" >> $2
