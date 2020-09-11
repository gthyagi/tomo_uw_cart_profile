#!/bin/sh

# creating layer nc and txt files
for value in $(cat ./pre_proc_dir/depth_mod.txt | cut -f1); do 
	echo $value 
	awk -v depth=$value '{if($3 == depth) print $1, $2, $4}' ./pre_proc_dir/mitp08_tomo_mod.txt | column -t > ./pre_proc_dir/nc_txt_dir/tomo_${value}.txt 
	gmt xyz2grd ./pre_proc_dir/nc_txt_dir/tomo_${value}.txt -G./pre_proc_dir/nc_txt_dir/tomo_${value}.nc -Rg -I0.7 
done