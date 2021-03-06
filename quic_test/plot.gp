# Linux/Windows users should download the 'Clear Sans' font and
#  use the following line.
set terminal pdfcairo enhanced font "Clear Sans, 20" linewidth 2 rounded dashed

set style line 80 lc rgb "#808080" lt 1 lw 0.75
# Border: 3 (X & Y axes)
set border 3 back ls 80

set style line 81 lc rgb "#808080" lt 1 lw 0.50 # dt 3
set style line 82 lc rgb "#999999" lt 1 lw 0.25 # dt 3
set grid ytics xtics mxtics back ls 81, ls 82

# Based on colorbrewer2.org's Set1 palette.
set style line 1 lt 1 lc rgb "#e41a1c" lw 1.0
set style line 2 lt 1 lc rgb "#377eb8" lw 1.0
set style line 3 lt 1 lc rgb "#4daf4a" lw 1.0
set style line 4 lt 1 lc rgb "#984ea3" lw 1.0
set style line 5 lt 1 lc rgb "#ff7f00" lw 1.0
set style line 6 lt 1 lc rgb "#a65628" lw 1.0
set style line 9 lt 1 lc rgb "#202020" lw 1.0

set xtics border in scale 1,0.5 nomirror norotate autojustify
set ytics border in scale 1,0.5 nomirror norotate autojustify

set tics in

set xtics nomirror
set ytics nomirror

set key outside top horizontal
set key samplen 4 spacing 1.2 width 2

# set lmargin 8
# set rmargin 2

X_MIN=0.08
X_MAX=5.12

Y_MAX=10
Y_MIN=0.001

# set logscale x
# set xrange [X_MIN-0.01:X_MAX]
# set mxtics 10

# set logscale y
# set yrange [Y_MIN*100:Y_MAX*100]
# set mytics 10

set ylabel "Throughput (in MBit/s)" offset 1.5,0
set xlabel "Time (in s)" offset 0,0.5


set output OUT_FILE
plot IN_FILE  u ($1):($2) t 'QUIC2' ls 1 pt 2 ps 0.8
unset output

