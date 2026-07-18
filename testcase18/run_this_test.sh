#!/bin/bash
set -e
NPROC=8
MAXIT=40

SRUFATT_HOME=/Users/xumijian/Codes/SurfATTPP/bin
input_params=input_params.yml

cp ../examples/02_checkerboard_radial_ani/$input_params ./
cp ../examples/02_checkerboard_radial_ani/src_rec_file_ph.csv ./
cp ../examples/02_checkerboard_radial_ani/src_rec_file_gr.csv ./

pta setpar $input_params inversion.niter $MAXIT

# provide source-receiver geometry at the paths referenced by input_params.yml;
# SURFATT_cb_fwd overwrites them with synthetic traveltimes
mkdir -p OUTPUT_FILES
cp src_rec_file_ph.csv OUTPUT_FILES/src_rec_file_forward_RL_PH.csv
cp src_rec_file_ph.csv OUTPUT_FILES/src_rec_file_forward_LV_PH.csv
cp src_rec_file_gr.csv OUTPUT_FILES/src_rec_file_forward_RL_GR.csv
cp src_rec_file_gr.csv OUTPUT_FILES/src_rec_file_forward_LV_GR.csv

# create 2x3x2 radial-anisotropy checkers (-r) with Vs/zeta perturbations
# and forward simulate Rayleigh + Love traveltimes
mpirun -np $NPROC $SRUFATT_HOME/SURFATT_cb_fwd -i $input_params -n 2/3/2 -s 2 -r -m 0.2 -p 0.08/0.1

# inversion for Vsv and radial anisotropy (model_para_type=2)
mpirun -np $NPROC $SRUFATT_HOME/SURFATT_tomo -i $input_params
