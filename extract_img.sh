#!/bin/bash
while IFS='' read -r line || [[ -n "$line" ]]; do
	a=( $line );
	extr="http://www.flickr.com/photo_zoom.gne?id=";
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
		wget -O ./images/$name.jpg `cat photo_zoom.gne\?id="$name" | grep -B 1 "Download the Large 1024 size of this photo" | head -n 1 | sed -e 's/.*="//' -e 's/">//'`
	fi

done < "$1"

rm photo*
