#!/bin/bash
set -e
NPROC=8
MAXIT=40

SRUFATT_HOME=/Users/xumijian/Codes/SurfATTPP/bin
input_params=input_params_fwd.yml

cp ../examples/01_checkerboard_ani/$input_params ./
cp ../examples/01_checkerboard_ani/src_rec_file.csv ./src_rec_test_data_PH.csv

# create 2x3x2 checkers and forward simulate surface traveltimes
mpirun -np $NPROC $SRUFATT_HOME/surfatt_cb_fwd -i $input_params -n 3/3/2 -A 2/2/2/120 -m 0.2 -p 0.08/0.08 -s 5

# inversion 
cp OUTPUT_FILES/src_rec_file_forward_PH.csv ./src_rec_test_data_PH.csv
mpirun -np $NPROC $SRUFATT_HOME/surfatt_tomo -i $input_params
