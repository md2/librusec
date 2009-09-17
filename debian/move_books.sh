#!/bin/sh
[ $# -eq 1 ] || exit 1
from=$1
to=/usr/share/drupal6/b
find $from/ -type f -regex '.*/[1-9][0-9]*\.fb2' | 
while read i; do
	subdir=`md5sum -b "$i" | cut -b1,2`;
	mv -i "$i" $to/$subdir/ &&
	echo $i;
done

