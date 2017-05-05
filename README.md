# flickr_get_img
Bash script to automatically download photos given photo query ID (User ID not required)

Originally written to extract Flickr photos in dataset Dubrovnik6K (http://www.cs.cornell.edu/projects/p2f/), a subset of SFM data.

Data from the original webiste doesn't include the images but only Flickr user ID and photo ID. The script follows the instruction of the Dubrovnik6K dataset usage (available in the link above), and automatically downloads all images with known focal length.

### Usage
The only argument is the list file. An example list file is included in this directory. It's also the real list file of the original Dubrovnik6K dataset. Simply type in the shell:
```bash
      bash extract_img.sh list.db.txt
```

### Brief explanation using `wget` , `grep` and `sed` to search in the webpage source
The main idea is to search for the target photo link in the source. In our case, we search for the string "Download the Large 1024 size of this photo", which is the next line to the photo link to be downloaded. The query string could be replaced by any other string for your purpose. The following `grep` command returns us the line of string right before the query string:
```bash
      grep -B 1 "Download the Large 1024 size of this photo"
```

Then I get: `<a href="https://c1.staticflickr.com/3/xxx/xxxxxx.jpg"> ` and I want to extract only the photo link from this string. Basically I want to get rid of strings in front of `="` and after `">`

'sed' is a [stream editor](https://www.gnu.org/software/sed/manual/html_node/Regular-Expressions.html). `s/.*="//` searches for everything before `="` and replace it with `//`, empty string. `'s/">//'` searches for `">` and replace it with empty string. Then what's remained would be the image link: `https://c1.staticflickr.com/3/xxx/xxxxxx.jpg`
```bash
      sed -e 's/.*="//' -e 's/">//'`
```

Then we could use `wget -O ./output_dir image_link_get_from_above` to save the image to a desired directory (and file name).
