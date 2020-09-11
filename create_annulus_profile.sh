#!/bin/sh

# Extract tomography data along the profile
rm ./pre_proc_dir/profile_tomo.txt 
awk '{print $1, $2}' ./pre_proc_dir/great_circle_coords.txt > ./pre_proc_dir/great_circle_lonlat.txt
awk '{print $3}' ./pre_proc_dir/great_circle_coords.txt > ./pre_proc_dir/great_circle_len_deg.txt
for value in $(cat ./pre_proc_dir/depth_mod.txt | cut -f1); do
	echo $value
	gmt grdtrack -fg -G./pre_proc_dir/nc_txt_dir/tomo_${value}.nc ./pre_proc_dir/great_circle_lonlat.txt | \
		awk -v depth=$value '{print $1, $2, $3, $4, $5 = depth}'> ./pre_proc_dir/test_tomo.txt
	paste ./pre_proc_dir/test_tomo.txt ./pre_proc_dir/great_circle_len_deg.txt | column -t >> ./pre_proc_dir/profile_tomo.txt 
done

rm ./pre_proc_dir/test_* 