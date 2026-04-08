#!/bin/bash
set -e
NPROC=8
MAXIT=40

pos_str=19.5/-155.5
angle=-30

SRUFATT_HOME=/Users/xumijian/Codes/SurfATTPP/bin
input_params=input_params.yml

cp ../examples/04_hawaii_topo/$input_params ./
cp ../examples/04_hawaii_topo/src_rec_file_raw.csv ./
cp ../examples/04_hawaii_topo/hawaii.nc ./

# download topography
# gmt grdcut @earth_relief_01m -R-157/-152/18/21 -Ghawaii.nc

# rotate source receiver file
$SRUFATT_HOME/SURFATT_rotate_src_rec -i src_rec_file_raw.csv -a $angle -c $pos_str -o src_rec_file_rotated.csv

# rotate topography
$SRUFATT_HOME/SURFATT_rotate_topo -i hawaii.nc -a $angle -c $pos_str -x -0.75/0.8 -y -0.75/1 -o hawaii_rotated.nc

# inversion 
mpirun -np $NPROC $SRUFATT_HOME/SURFATT_tomo -i $input_params

# rotate initial model
$SRUFATT_HOME/SURFATT_rotate_model -i OUTPUT_FILES/initial_model.h5 -a `echo $angle | awk '{print -$1}'` -c $pos_str -o OUTPUT_FILES/initial_model.csv

# rotate back to original position
$SRUFATT_HOME/SURFATT_rotate_model -i OUTPUT_FILES/final_model.h5 -a `echo $angle | awk '{print -$1}'` -c $pos_str -o OUTPUT_FILES/final_model.csv