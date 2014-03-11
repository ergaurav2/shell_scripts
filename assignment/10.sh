#!bin/bash
rm -rf PasswordTest
if [ $# != 1 ]; then
	echo "Error: Invalid Number of Arguments!"
	exit 1
fi
if [ ! -e $1 ]; then
	echo "Error: Invalid File!"
	exit 1
fi
oldIFS=$IFS
IFS=$'\n'
passwordlist=$(cat $1)
dict=$(cat /usr/share/dict/words)
flag=0;
for pwd in $passwordlist
do
	if  echo "$pwd" | grep '.*\{8\}.*' > /dev/null  &&  echo $pwd | grep '.*[0-9].*' > /dev/null  &&  echo $pwd | egrep '(@|$|%|&|*|+|-|=)' > /dev/null
	then
		len=${#pwd}
		len1=len
		let len1--
		let len1--
		let len1--
		let len1--
		for i in $(seq 0 $len1)
		do
			for j in $(seq 4 $len)
			do	
				substr=${pwd:$i:$j}
				for word in $dict
				do
					
					if [ "$word" == "$substr" ]
					then
						flag=1;					
						break 3;
					fi
				done
			done
		done
	else
		flag=1;
	fi
if [ $flag -eq 0 ]
then 
	echo "STRONG" >> PasswordTest
else
	echo "WEAK" >> PasswordTest
fi
done
IFS=$oldIFS
