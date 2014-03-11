#!bin/bash
while [ $# -gt 1 ]
do
	unset firsttime
	if [ ! -e $1 ]; then
	echo "Error: Invalid File/Directory!"
	else
	  	. $0 $1
fi
	shift
done
if [ ! -e $1 ]; then
	echo "Error: Invalid File/Directory!"
	exit 1
fi

if [ -z $firsttime ]
then
	str=$(pwd)
	str1=$str"/"$0
	export inputpath=$str1	
	export firsttime=1
fi
if [ -f $1 ]; then
echo $1
else
	files=${1-"."}"/*"
	echo ${1-"."}":"
	for filepath in $files
	do	
		if [ -d "$filepath" ]
		then
			bash "$inputpath" "$filepath"
		else
			echo `basename "$filepath"`
		fi
	done
fi
