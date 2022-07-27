#!/bin/bash

# langkah 1 : membuat directory nya
DIR="/home/tyas/data"
if [[ -d "DIR" ]]; then
		echo "folder data ditemukan"
	else
		echo "not found - creating new folder"
		mkdir /home/tyas/data
fi

# langkah 2 : ambil datanya
wget -p ./data https://drive.google.com/file/d/1rKkUQU-sXIDka3rVNBahp6q3wDhrPY-1/view

# langkah 3 : unzip datanya
unzip $DIR/data.zip

# langkah 4 : gabungkan file 2019-Nov-sample dengan 2019-Oct-sample
csvstack $DIR/2019-Nov-sample.csv $DIR/2019-Oct-sample.csv > $DIR/2019-data.csv

# langkah 5 : seleksi kolom yang mau digunakan, filter, dan split data
csvcut -c event_time,event_type,product_id,category_id,brand,price $DIR/2019-data.csv | grep 'purchase' | awk -F"[.]" '{print $1","$2" "$3}' >> 2019-purchased.csv 

# langkah 6 : bikin nama kolom baru
echo "event_time,event_type,product_id,category_id,category,product_type,brand,price" $DIR/2019-purchased.csv

