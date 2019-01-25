#!/bin/sh
# Graph the average of all throughput files
# Assuming that the throughput file is in the same directory as the perl program
number=1
# Store filename
filename=$1
# Store packet type name
paket_type=$2
# Array for storing throughput value
array=()
# Array for storing the number of lines in a file
declare -i linenum
linenum=0
declare -i sum
sum=0
while [ -e "${filename}-${number}.thp" ]
do
	echo "$filename-$number.thp !"
	linenum=0
	# Read one line from file
	while read line
	do
		if [ $number -eq 1 ] 
		then
			# Stores the amount of data in the second column from the file
			array+=(`echo $line | cut -d ' ' -f2`)
			#echo "$linenum ${array[linenum]}"
			((linenum++))
		else
			# Add the second and subsequent files to the previous array
			sum=`echo $line | cut -d ' ' -f2`
			array[linenum]=`expr ${array[linenum]} + $sum `
			#echo "$linenum ${array[linenum]}"
			((linenum++))
		fi
	done < "$filename-$number.thp"
	# Add 1 to the numerical value of the throughput file
	((number++))
done
if [ $number -ne 1 ]
then
	# Divide the content of the array by the number of throughput files added
	# Initialize the output file
	if [ -e "${filename}-ave.thp" ]
	then
		rm "${filename}-ave.thp"
	fi
	linenum=1
	((number--))
	for array in "${array[@]}"
	do
		echo "$linenum `expr $array / $number`" >> ${filename}-ave.thp
		((linenum++))
	done
	#echo $number
	# Finally, generate a graph from the output thp file
	gnuplot -e "
		set xtics 0 , 1 ;
		set title '${filename}-ave.thp     throughput of $packet_type' ;
		set xlabel 'second' ;
		set ylabel 'throughput : byte' ;
		plot '${filename}-ave.thp' with line ;
		save '${filename}-ave.plt' ;
	"
fi
