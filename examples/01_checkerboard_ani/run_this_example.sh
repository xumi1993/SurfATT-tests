#!/bin/bash

NPROC=8

mkdir -p OUTPUT_FILES
cp src_rec_file_100.csv OUTPUT_FILES/src_rec_file_forward_ph.csv

# create 2x3x2 checkers and forward simulate surface traveltimes
mpirun -np $NPROC ../../bin/surfatt_cb_fwd -i input_params.yml -n 3/3/2 -A 2/2/2 -m 0.2 -p 0.08 -a 0.08/135 -s 5

# inversion 
mpirun -np $NPROC ../../bin/surfatt_tomo -i input_params.yml
