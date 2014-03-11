#!bin/bash
if [ ! -e ~/TRASH ]
then
	mkdir ~/TRASH
fi	
noofarg=$#
for i in $(seq 1 $noofarg)
do
	if [ ! -e $1 ] || [ ! -f $1 ]; then
		echo "Error: Invalid File!"
		continue
	fi	
	file $1 | grep "compress" > /dev/null
	if [ $? -ne 0 ]
	then
			gzip -f $1
			mv $1.gz ~/TRASH
	else
			mv $1 ~/TRASH
	fi
	shift
	
done

filelist=$(find ~/TRASH -type f -atime +1)
for file in $filelist
do		
	rm -f $file
done
