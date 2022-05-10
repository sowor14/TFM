file1="table_LJ_N20k_11.dat"
file2="table_LJ_N20k_1j.dat"
file3="table_CS_N20k_3.dat"

load "/home/usuario/Documentos/Master/9_Varis/set1.pal"

#set terminal pngcairo enhanced font "verdana,9" fontscale 1.0 size 1024, 768
#set output 'pot_used.png'

set xzeroaxis
set yzeroaxis

set xtics auto nomirror
set ytics auto nomirror

set xlabel "r*=r/a"
set ylabel "U*=U/U_a" enhanced

set autoscale
set xrange[0:4]
set yrange[-2:5]
set key top right

plot file1 u 2:3 w l ls 1 lw 2 t"LJ",\
     file2 u 2:3 w l ls 2 dt 2 lw 2 t"LJ-LB",\
     file3 u 2:3 w l ls 3 dt 4 lw 2 t"CSW"

set term qt
reset
pause-1
