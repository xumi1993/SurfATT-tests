#!/bin/bash
set -e
NPROC=8
MAXIT=40

SRUFATT_HOME=/Users/xumijian/Codes/SurfATTPP/bin
input_params=input_params.yaml

python build_h5_model.py

pta setpar $input_params data.src_rec_file_ph src_rec_file_ph.csv
head -n 1000 src_rec_data_wus.csv > src_rec_file_ph.csv

# inversion 
mpirun -np $NPROC $SRUFATT_HOME/SURFATT_tomo -i $input_params -f
