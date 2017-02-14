#!/bin/bash

dir=$1
if [ -e $dir ];					#checks if the directory exists
then
	for i in $dir/*				#for every file in the directory...
	do
		i1=`expr index "$i" PTF`	#to later exclude the path so we get only the filename
		end=${i:(-3)}			#gets the last three characters of the file name... this is a stupid way to get the suffix
		if [ $end = 'its' ];		#i.e. checks if this is a fits file
		then
			wsuff_f=${i:$i1-1}	#gets only the filename without the path, using the index from before
			suff=fits		
			f=${wsuff_f%.$suff}	#removes the .fits suffix
			check_cat=$dir/$f.cat	#adds the .cat suffix to the same string
			if [ -e $check_cat ];	#checks if the .cat file exists
			then
				:	
			else
				echo $f		#prints the names of the fits files for which no corresponding catalog exists
			fi
		fi
	done
else
	echo "This directory does not exist."	#in case of typos
	exit 1
fi
