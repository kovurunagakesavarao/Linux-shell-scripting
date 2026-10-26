#!/bin/bash

src_dir=$1
dest_dir=$2
days=${3:-14}


if [ -z $src_dir ] || [ -z $dest_dir ]; then
	echo "Source/destination Directory is missing"
	exit 1
fi

if [ ! -d $src_dir ]; then
	echo "Invalid path src_dir"
	exit 1
fi

if [ ! -d $dest_dir ]; then
	echo "invalid path dest dir "
	exit 1
fi

files=$(find $src_dir -type f -name "*.log" -mtime +$days)

timestamp=$(date +%Y-%M-%d:%H-%M-%S)
filename="$dest_dir/logs-$timestamp.tar.gz"

tar -czf $filename $files

if [ $? -ne 0 ]; then
	echo "log files Ziping failed"
        exit 1
else
	echo "Log files are archived "
	while IFS= read -r line
	do
		echo "$line is going to delete"
		rm -f $line
		echo "$line is deleted"
	done << EOF
$files	
EOF
fi


ls $dest_dir



