# flickr_get_img
Bash script to automatically download photos given photo query ID (User ID not required)

Originally written to extract Flickr photos in dataset Dubrovnik6K (http://www.cs.cornell.edu/projects/p2f/), a subset of SFM data.

Data from the original webiste doesn't include the images but only Flickr user ID and photo ID. The script follows the instruction of the Dubrovnik6K dataset usage (available in the link above), and automatically downloads all images with known focal length.

# Usage
The only argument is the list file. An example list file is included in this directory. It's also the real list file of the original Dubrovnik6K dataset. Simply type in the shell:
bash extract_img.sh list.db.txt
