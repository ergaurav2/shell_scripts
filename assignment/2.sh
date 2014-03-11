#!/bin/bash

if [ $# -gt 0 ]; then
	echo "Error! Invalid Number of Arguments"
	exit 1
fi
cat $0 | awk '{print $0}' > backup.sh
