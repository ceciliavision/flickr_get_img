#!/bin/bash
while IFS='' read -r line || [[ -n "$line" ]]; do
	a=( $line );
	extr="http://www.flickr.com/photo_zoom.gne?id=";
	extr2="http://www.flickr.com";
	ext=".jpg";
	# print length($a);
	if [[ -z "${a[2]// }" ]]; then # filter out files with focal length
		nd=(${a[0]//// });
		# echo "$a[1]";
		id_ext=(${a[0]//_/ });
		id=(${id_ext[-1]//./ });
		name=${id[0]};
		fullname=$extr$name;
		# echo "$fullname";
		wget "$fullname";
		img_link=$( cat photo_zoom.gne\?id="$name" | grep "Original" | head -n 1 | sed -e 's/.*="//' -e 's/">.*//' )
		rm photo* # cleaning
		wget "$extr2$img_link";
		img_full_link=$( cat index.html* | grep -B 1 "Download the Original size of this photo" | head -n 1 | sed -e 's/.*="//' -e 's/">.*//' )
		echo "$img_full_link";
		wget -O ./images_test/$name.jpg $img_full_link
		rm index.html* # cleaning
	fi

done < "$1"