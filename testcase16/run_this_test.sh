#!/bin/bash
set -e
NPROC=8
MAXIT=40

SRUFATT_HOME=/Users/xumijian/Codes/SurfATTPP/bin
input_params=input_params.yaml

python build_h5_model.py

# inversion 
mpirun -np $NPROC $SRUFATT_HOME/SURFATT_tomo -i $input_params -f
