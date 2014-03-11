#!bin/bash
if [ $# != 1 ]; then
	echo "Error: Invalid Number of Arguments!"
	exit 1
fi
oldIFS=$IFS
IFS=$''
lines=($(cat $1 | awk '{print $0}'))
j=0
size=${#lines}
let size--
for i in $(seq 0 $size)
do
	echo ${lines[$i]}
done
for line in $(cat $1)
do	 
	revline=""
	len=${#line}
	let len--
	for i in $(seq 0 $len)
	do
		c=${line:i:1}
		revline=$c$revline
	done
	revlines[$j]=$revline
	let j++
done
let j--
for k in $(seq 0 $j)
do
echo ${revlines[$k]}
done
