#!bin/bash
if [ $# != 1 ]; then
	echo "Error: Invalid Number of Arguments!"
	exit 1
fi
if [ ! -d $1 ]; then
	echo "Error: Input not a directory"
	exit 1
fi
echo $1
#declare -a filelist
oldIFS=$IFS
IFS=$'\n'
depth=0
printDir() {
	local filelist=($(ls $1))
	cd $1
	local arraycount=${#filelist[@]}
	let arraycount--
	for file in $(seq 0 $arraycount)
	do
		 currfile=${filelist[$file]} 
		if [ $depth -ne 0 ]; then
			for i in $(seq 1 $depth)
		do
			echo -n "|"
			echo -n "   "
		done
		fi
		echo "|-- "$currfile
		if [ -d "$currfile" ]; then
			depth=$(($depth + 1))
			printDir $currfile
		fi
	done
	cd ..
	let depth--
}
printDir $1
IFS=$oldIFS
