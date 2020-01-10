#!/bin/bash

filename=$1/$2
initial=$3
array1=(${initial//,/ })


 
if [[ $# -lt 2 || $# -gt 3 ]]; then
        echo "Too few or too many parameters"
        exit 4
elif [ ! -d $1 ]; then
        echo "The database does not exist"
        exit 3
elif [ !  -f $1/$2 ]; then
        echo "The table does not exists"
        exit 6
else
        tablecount=`head -n1 $1/$2 | grep -o "," | wc -l`
        y=`echo $3 | grep -o "," | wc -l`

        if [ $tablecount -eq 1 ]; then
                echo "Sorry, there are no columns in the schema, please try again"
		exit 8
	elif [ $# -eq 3 ]; then
		for i in "${array1[@]}"; do
     			if [[ $i -le 0 || $i -gt $tablecount+1 ]]; then
              			echo "Sorry, the columns passed does not match the schema."
          			exit 7
			fi
		done

	        myColumn=$(cat "$filename")
            	for i in ${array1[@]}; do
                	j="$j$i,"
            	done
            	j=`echo $j | sed 's/,$//'`
		echo "start_result"
		echo ""
            	cut -d ',' -f $j <<< "$myColumn"    
		echo ""
		echo "end_result"
		exit 0
	else
		
		table=$(cat $1/$2)
		echo "start_result"
		echo ""
		echo "$table"	
		echo ""
		echo "end_result"
		exit 0
	  
	fi

fi	
