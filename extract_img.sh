#!/bin/bash
while IFS='' read -r line || [[ -n "$line" ]]; do
	a=( $line );
	extr="http://www.flickr.com/photo_zoom.gne?id=";
	ext=".jpg";
	# print length($a);
	if [[ -z "${a[2]// }" ]]; then # filter out files with focal length, if loop can be comment out if no filtering is needed
		nd=(${a[0]//// }); # separate /
		# echo "$a[1]";
		id_ext=(${a[0]//_/ }); # separate the photo id
		id=(${id_ext[-1]//./ }); # separate the extension
		name=${id[0]};
		fullname=$extr$name; # concat to get the full webpage link
		# echo "$fullname";
		wget "$fullname"; # to inspect the webpage source in order to search (next line)
		wget -O ./images/$name.jpg `cat photo_zoom.gne\?id="$name" | grep -B 1 "Download the Large 1024 size of this photo" | head -n 1 | sed -e 's/.*="//' -e 's/">//'`
	fi

done < "$1"

rm photo* # clean up, remove all saved webpage sources
