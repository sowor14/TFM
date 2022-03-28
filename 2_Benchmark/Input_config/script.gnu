file1="csw.dat"
load "/home/usuario/Documentos/Master/9_Varis/set1.pal"

#set terminal pngcairo enhanced font "verdana,9" fontscale 1.0 size 1024, 768
#set output 'pot_cs.png'

set xzeroaxis
set yzeroaxis

set xtics auto nomirror
set ytics auto nomirror

set xlabel
set ylabel

set autoscale
#set xrange[0:15.8]
#set yrange[-1:7]
set key below width 1

plot file1 u 1:2 w l ls 1 lw 2 t"Temperature (K)",\
        '' u 1:5 w l ls 2 lw 2 t"Energy (kcal/mol)",\
        '' u 1:6 w l ls 3 lw 2 t"Pressure"

set term qt
reset
pause-1
