#!bin/bash
if [ $# != 1 ]; then
	echo "Error: Invalid Number of Arguments!"
	exit 1
fi
if [ ! -d $1 ]; then
	echo "Error: Input not a directory"
	exit 1
fi

declare -a oldfilelist
oldIFS=$IFS
IFS=$'\n'
oldfilelist=($(ls $1))
cd $1
pwd
arraycount=${#oldfilelist[@]}
let arraycount--
for file in $(seq 0 $arraycount)
do
	oldname=${oldfilelist[$file]}
	newname=$(echo $oldname | tr [A-Z] [a-z])
	if [ "$oldname" != "$newname" ]; then
		if [ -e $newname ]
		then
			echo "Warning: Not overwriting "$newname
		else
			mv $oldname $newname
		fi
	fi
done
IFS=$oldIFS
