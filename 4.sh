#!bin/bash
if [ $# != 3 ]; then
	echo "Error: Invalid Number of Arguments!"
	exit 1
fi
a=$1
b=$2
c=$3
for i in $(seq 0 2)
do  
	echo $1 | grep '^-\?[0-9]\+\.\?[0-9]*$' > /dev/null
	if [ $? -ne 0 ]; then
		echo "Error: Input not a number"
		exit 1
	fi
	shift
done
d=`echo $b*$b-4*$a*$c | bc`
res=$(echo "$d < 0" | bc)
if [ $res -ne 0 ]; then
	echo "No Solutions were found"
	exit 1
fi
sqrtd=$(bc -l << EOF
scale=5
sqrt( $d )
EOF
)
root1=$(echo "scale=5;(-$b + $sqrtd)/(2*$a)" | bc)
root2=$(echo "scale=5;(-$b - $sqrtd)/(2*$a)" | bc)
echo $root1","$root2
