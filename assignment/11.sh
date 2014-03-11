#!bin/bash
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
copylist=$(cat $1)
listsize=1;
newlist[0]=${copylist:0:19}
n=0
for copy in $copylist
do
	rollno1=${copy:0:9}
	rollno2=${copy:10:9}
	for i in $(seq 0 $n)
	do
		list=${newlist[$i]}
		if echo $list | grep "$rollno1" > /dev/null && echo $list | grep "$rollno2" > /dev/null
		then
			break	
		elif echo $list | grep "$rollno1" > /dev/null
		then
			list=$list" "$rollno2	
			newlist[$i]=$list
			break
		elif echo $list | grep "$rollno2" > /dev/null
		then
			list=$list" "$rollno1	
			newlist[$i]=$list
			break
		elif [ $i == $n ]
		then
			let n++
			newlist[n]=$copy
		fi
	done
done

for i in $(seq 0 $n)
do
		let k=$i+1
		for j in $(seq $k $n)
		do
			IFS=$' '
			rollist=(${newlist[$i]})
			IFS=$'\n'
			siz=${#rollist[@]}
			flag=1
			let siz--
			for p in $(seq 0 $siz)
			do			
				echo ${newlist[$j]} | grep "${rollist[$p]}" > /dev/null			
				if [ $? -eq 0 ]; then			
			newlist[$j]=$(echo "${newlist[$j]}" | sed 's/'${rollist[$p]}' //')	
				flag=0
				fi
			done
			if [ $flag -eq 0 ]
			then
				newlist[$i]=${newlist[$i]}" "${newlist[$j]}
				unset newlist[$j]
			fi
		done
done

for i in $(seq 0 $n)
do
	IFS=$' '
	a=(${newlist[$i]})
	IFS=$'\n'
	siz=${#a[@]}
		flag=1
			let siz--
			for p in $(seq 0 $siz)
			do
				minind=$p
				for q in $(seq $p $siz)
				do
					if [ ${a[$q]} \<  ${a[$minind]} ]
					then
						minind=$q
					fi
				done
				temp=${a[$p]}
				a[$p]=${a[$minind]}
				a[$minind]=$temp
			done
			newlist[$i]=${a[0]}
			for p in $(seq 1 $siz)
			do						
				newlist[$i]=${newlist[$i]}" "${a[$p]}
			done
done

for i in $(seq 0 $n)
do
		
		min=${newlist[$i]:0:9}
		ele=${newlist[$i]}
		ind=$i
		for j in $(seq $i $n); do
		rollno=${newlist[$j]:0:9}
		if [ "$min" \> "$rollno" ];then 		
			min=${newlist[$j]:0:9}
			ele=${newlist[$j]}
			ind=$j
		fi
		done
		newlist[$ind]=${newlist[$i]}		
		newlist[$i]=$ele
		
done

rm -rf CopyGroups
for i in $(seq 0 $n)
do
		list=${newlist[$i]}
		if [ ! -z $list ];then
			echo $list >> CopyGroups
		fi
done
