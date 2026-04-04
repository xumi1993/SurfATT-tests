#!/bin/bash

SRUFATT_HOME=/Users/xumijian/Codes/SurfATTPP/bin

NPROC=8

input_params=input_params.yml

cp ../examples/00_checkerboard_iso/$input_params ./
cp ../examples/00_checkerboard_iso/src_rec_file_ph.csv ./

pta setpar $input_params inversion.is_anisotropy True

mpirun -np $NPROC $SRUFATT_HOME/SURFATT_cb_fwd -i $input_params -n 2/3/3 -a 2/3/1 -m 0.2 -p 0.08/0.04 -s 3
