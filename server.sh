#!/bin/bash

trap ctrl_c INT
function ctrl_c() {
	rm server_pipe
	exit 0 
}

mkfifo server_pipe
 
while true; do

         read args < server_pipe
         set -- $args 
 
         case "$1" in
		 shutdown)
			rm server_pipe
			echo "Server is shutting down"
			exit 0
			;;
                 create_database)
			answer=`./create_database.sh $3 &` 
			echo $answer > $2"_pipe"
                        ;;   
                 create_table)
                        answer=`./create_table.sh $3 $4 $5 &`
                        echo $answer > $2"_pipe"
			;;
                 insert)
                        answer=`./insert.sh $3 $4 $5 &`
                        echo $answer > $2"_pipe"
			;; 
                 select)
                        answer=`./query.sh $3 $4 $5 &`
                        echo "$answer" > $2"_pipe"
			;; 
                 *)
                        echo "Error: bad request"
                        exit 1
			;;
 
        esac
done
