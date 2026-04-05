#!/bin/bash

SRUFATT_HOME=/Users/xumijian/Codes/SurfATTPP/bin

NPROC=8

input_params=input_params.yml
cp ../examples/00_checkerboard_iso/$input_params ./

# upadate parameters with PyTomoATT
pta setpar $input_params data.src_rec_file_ph src_rec_file_forward_PH.csv
pta setpar $input_params data.vel_type "[True, False]"
pta setpar $input_params postproc.smooth_method 1
pta setpar $input_params inversion.is_anisotropy False
pta setpar $input_params inversion.optim_method 0
mpirun -np $NPROC $SRUFATT_HOME/SURFATT_tomo -i $input_params