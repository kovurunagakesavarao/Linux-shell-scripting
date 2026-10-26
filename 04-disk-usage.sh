#!/bin/bash

diskfreeoutput=$(df -hT)
threshold=20
echo "ds"
#echo :
while IFS= read -r line
	do
		usage=$(echo "$line" | awk '{print $6}' | cut -d "%" -f1)
		name=$(echo "$line" | awk '{print $7}')
		if [ $usage -ge 60 ]; then
			echo "$usage - $name"
		fi
	       
       done << EOF
$diskfreeoutput
EOF


