#!/bin/bash
set -e
NPROC=8
MAXIT=40

SRUFATT_HOME=/Users/xumijian/Codes/SurfATTPP/bin
input_params=input_params.yaml
base_dir=../examples/05_westUS_ani

cp $base_dir/$input_params ./
head -n 1000 $base_dir/src_rec_data_wus.csv > src_rec_file_ph.csv
cp $base_dir/csem.nc ./

python build_h5_model.py

pta setpar $input_params data.src_rec_file_ph src_rec_file_ph.csv
pta setpar $input_params domain.grid_method 1
pta setpar $input_params inversion.niter 3

mpirun -np $NPROC $SRUFATT_HOME/SURFATT_tomo -i $input_params
