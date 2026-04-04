#!/bin/bash

SRUFATT_HOME=/Users/xumijian/Codes/SurfATTPP/bin

NPROC=8

cp ../examples/00_checkerboard_iso/input_params.yml ./
cp ../examples/00_checkerboard_iso/src_rec_file_ph.csv ./

mpirun -np $NPROC $SRUFATT_HOME/SURFATT_tomo -i input_params.yml -f