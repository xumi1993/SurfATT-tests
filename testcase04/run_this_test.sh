#!/bin/bash

SRUFATT_HOME=/Users/xumijian/Codes/SurfATTPP/bin

NPROC=8

cp ../examples/00_checkerboard_iso/input_params.yml ./
cp ../examples/00_checkerboard_iso/src_rec_file_*.csv ./

# upadate parameters with PyTomoATT
pta setpar input_params.yml data.vel_type "[True, True]"
pta setpar input_params.yml model.init_model_type 1

mpirun -np $NPROC $SRUFATT_HOME/SURFATT_tomo -i input_params.yml -f