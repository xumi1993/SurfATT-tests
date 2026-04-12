#!/bin/bash

NPROC=8
SRUFATT_HOME=/Users/xumijian/Codes/SurfATTPP/bin

mkdir -p OUTPUT_FILES
cp src_rec_file_100.csv src_rec_test_data_PH.csv

# create 2x3x2 checkers and forward simulate surface traveltimes
mpirun -np $NPROC $SRUFATT_HOME/SURFATT_cb_fwd -i input_params_fwd.yml -n 3/3/2 -a 2/2/2/135 -m 0.2 -p 0.08/0.004 -s 5

# inversion 
mpirun -np $NPROC $SRUFATT_HOME/SURFATT_tomo -i input_params.yml
