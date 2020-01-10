#!/bin/bash

if [ $# -eq 1 ]; then		


	trap ctrl_c INT
	function ctrl_c() {
        	 rm $clientid"_pipe"
         	exit 0
	}	

	if [ ! -p server_pipe ]; then
		echo "Sorry, the server seems to be offline. Please try again shortly!"
		exit 9
	fi
 
	clientid=$1
	mkfifo $clientid"_pipe"


	while [ "$1" != "0" ]; do
	
		echo "What would you like to do" $clientid"?"
		read args
		set -- $args
	
	  	case "$1" in
			 exit)
				echo "Have a good day, Goodbye!"
				rm $clientid"_pipe"
				exit 0
				;;
			shutdown)
				echo "Password: "
				read password
				if [ "$password" == "ilovebash" ]; then
					echo "Okay, you are shutting down the server. Goodbye!"
					echo "shutdown" > server_pipe
					rm $clientid"_pipe"
					exit 0
				else
					echo "Sorry, that is incorrect"
				fi
				;;
                 	create_database)
				echo $1 $clientid $2
                  		echo $1 $clientid $2 > server_pipe
				while [ -s $clientid"_pipe" ]; do
					sleep 1
				done
				read answer < $clientid"_pipe"
				echo $answer  
                        	;;
                 	create_table)
				echo $1 $clientid $2 $3 $4 > server_pipe
                       		while [ -s $clientid"_pipe" ]; do 
                                	 sleep 1
                        	done
                        	read answer < $clientid"_pipe" 
                        	echo $answer  
				;;
                 	insert)
                        	echo $1 $clientid $2 $3 $4 > server_pipe
                        	while [ -s $clientid"_pipe" ]; do
					sleep 1
				done
				read answer < $clientid"_pipe"
				echo $answer
				;;
               	 	select)
                        	echo $1 $clientid $2 $3 $4 > server_pipe
                 		while [ -s $clientid"_pipe" ]; do
					sleep 1
				done
				while IFS= read -r line; do
					echo "$line"
				done < $clientid"_pipe"
				;;
		 	*)
                  		echo "Error: bad request"
				exit 1
				;;
		esac

	done	
fi

echo "Sorry, no argument provided"
exit 0

	 
