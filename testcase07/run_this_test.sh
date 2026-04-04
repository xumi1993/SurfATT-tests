#!/bin/bash

SRUFATT_HOME=/Users/xumijian/Codes/SurfATTPP/bin

NPROC=8

cp ../examples/00_checkerboard_iso/input_params.yml ./
cp ../examples/00_checkerboard_iso/src_rec_file_ph.csv ./

mpirun -np $NPROC $SRUFATT_HOME/SURFATT_cb_fwd -i input_params.yml -n 2/3/2 -m 0.2 -p 0.08
