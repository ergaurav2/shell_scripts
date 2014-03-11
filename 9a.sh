#!bin/bash
oldIFS=$IFS
IFS=$'\n'
strcmp() {
if [ "$1" == "$2" ]
then
	echo 0
elif [ "$1" \< "$2" ]
then
	echo "-1"
elif [ "$1" \> "$2" ]
then
	echo "1"
fi
}

strlen() {
	echo ${#1} 
}

strcat() {
newstring=$1$2
echo "$newstring"
}

strstr() {
ind=`expr index "$1" "$2"`
let ind--
echo $ind
}

strtok() {
if [ -n "$1" ];then
str1=$1
fi
tokens=$2
str2=""
len1=${#str1}
let len1--
len2=${#tokens}
let len2--
for i in $(seq 0 $len1)
do
	ch=${str1:$i:1}
	for j in $(seq 0 $len2)
	do
		tok=${tokens:$j:1}
		if [ "$ch" == "$tok" ]; then
			break 2
		fi
	done
	str2=$str2$ch
done
let i++
str1=${str1:$i}
echo $str2
}
