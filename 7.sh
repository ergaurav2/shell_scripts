#!bin/bash
oldIFS=$IFS
IFS=$'\n'
	filelist=($(sudo find /etc/ -type f -daystart -atime 1 | awk '{print $0}'))
	arraycount=${#filelist[@]}
	let arraycount--
	touch AccessLog
	for file in $(seq 0 $arraycount)
	do 
		 currfile=${filelist[$file]}
		 ls -ul --time-style=+'%b %d %H:%M' $currfile | awk '{print $9"\t"$6" "$7" "$8}' >> AccessLog
	done
IFS=$oldIFS

