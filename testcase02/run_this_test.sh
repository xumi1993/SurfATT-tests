#!/bin/bash

SRUFATT_HOME=/Users/xumijian/Codes/SurfATTPP/bin

cp ../examples/00_checkerboard_iso/input_params.yml ./
cp ../examples/00_checkerboard_iso/src_rec_file_gr.csv ./

# upadate parameters with PyTomoATT
pta setpar input_params.yml data.vel_type "[False, True]"

mpirun -np 8 $SRUFATT_HOME/SURFATT_tomo -i input_params.yml -f