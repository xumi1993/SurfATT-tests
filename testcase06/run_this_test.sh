#!/bin/bash

SRUFATT_HOME=/Users/xumijian/Codes/SurfATTPP/bin

NPROC=8

cp ../examples/01_checkerboard_ani/input_params_fwd.yml ./
cp ../examples/01_checkerboard_ani/src_rec_file_25.csv ./src_rec_test_data_PH.csv
cp ../examples/01_checkerboard_ani/target_model.h5 ./


# upadate parameters with PyTomoATT
input_params=input_params_fwd.yml
target_model=target_model.h5
pta setpar $input_params data.vel_type "[True, False]"
pta setpar $input_params model.init_model_type 2
pta setpar $input_params model.init_model_path $target_model
pta setpar $input_params inversion.is_anisotropy True

mpirun -np $NPROC $SRUFATT_HOME/SURFATT_tomo -i $input_params -f