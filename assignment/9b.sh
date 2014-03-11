#!bin/bash
. 9a.sh

if [ $# != 2 ]; then
	echo "Error: Invalid Number of Arguments!"
	exit 1
fi

strcmp $1 $2
strlen $1
strlen $2
strcat $1 $2
strtok $1 $2
strstr $1 $2
