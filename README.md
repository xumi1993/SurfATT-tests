# SurfATT-tests Testcase Summary

This repository contains 16 test scenarios (`testcase01` to `testcase16`) that cover SurfATT core workflows across different data types, model setups, optimization/smoothing strategies, anisotropy, and topography-enabled cases.

## Testcase Overview

| Testcase | Main Program | What It Tests | Key Settings |
|---|---|---|---|
| `testcase01` | `SURFATT_tomo` | Baseline isotropic inversion using phase velocity only (`PH`) | `vel_type=[True,False]`, input `src_rec_file_ph.csv` |
| `testcase02` | `SURFATT_tomo` | Baseline isotropic inversion using group velocity only (`GR`) | `vel_type=[False,True]`, input `src_rec_file_gr.csv` |
| `testcase03` | `SURFATT_tomo` | Joint inversion of phase + group velocity | `vel_type=[True,True]`, both `PH/GR` data files used |
| `testcase04` | `SURFATT_tomo` | Joint inversion with 1D initial model mode | `vel_type=[True,True]`, `init_model_type=1` |
| `testcase05` | `SURFATT_tomo -f` | Forward run from a known 3D model (isotropic mode) | Based on `01_checkerboard_ani`, `init_model_type=2`, `init_model_path=target_model.h5`, `is_anisotropy=False`, `grid_method=1` |
| `testcase06` | `SURFATT_tomo -f` | Forward run from a known 3D model (anisotropic mode) | Same as testcase05, but `is_anisotropy=True` |
| `testcase07` | `SURFATT_cb_fwd` | Isotropic checkerboard forward synthetic generation | `-n 2/3/2 -m 0.2 -p 0.08` |
| `testcase08` | `SURFATT_cb_fwd` | Anisotropic checkerboard forward synthetic generation (basic) | `is_anisotropy=True`, `-n 2/3/2 -a 2/3/1 -p 0.08/0.04` |
| `testcase09` | `SURFATT_cb_fwd` | Anisotropic checkerboard forward synthetic generation (enhanced settings) | `is_anisotropy=True`, `-n 2/3/2 -a 2/3/2 -p 0.08/0.04 -s 5` |
| `testcase10` | `SURFATT_tomo` | Inversion strategy comparison: `smooth_method=1` + `optim_method=0` | Phase-velocity dataset, `niter=40`, isotropic |
| `testcase11` | `SURFATT_tomo` | Inversion strategy comparison: `smooth_method=0` + `optim_method=0` | Phase-velocity dataset, `niter=40`, isotropic |
| `testcase12` | `SURFATT_tomo` | Inversion strategy comparison: `smooth_method=0` + `optim_method=1` | Phase-velocity dataset, `niter=40`, isotropic |
| `testcase13` | `SURFATT_cb_fwd` + `SURFATT_tomo` | End-to-end loop test: synthesize data first, then invert | Step 1 generates `OUTPUT_FILES/src_rec_file_forward_PH.csv`; step 2 inverts it with `init_model_type=1`, `optim_method=1` |
| `testcase14` | `SURFATT_rotate_*` + `SURFATT_tomo` | Realistic workflow with topography and coordinate rotation (Hawaii) | Rotate station/event geometry + topo, invert with `topo.is_consider_topo=True`, then rotate model results back |
| `testcase15` | `SURFATT_cb_fwd` + `SURFATT_tomo` | Anisotropic end-to-end loop with larger input dataset | Use `src_rec_file_100.csv`, synthesize `3/3/2` checkerboard with anisotropy (`-a 2/2/2`), then invert |
| `testcase16` | `SURFATT_tomo -f` | Forward run using a regional 3D initial model (`csem.h5`) on a WUS-scale domain | `init_model_type=2`, `init_model_path=csem.h5`, `vel_type=[True,False]`, `grid_method=1`, domain `lon[-125.5,-103.5]`, `lat[29,49.5]`, `depth[0,80]` |

## Coverage Dimensions

- Data-type coverage: phase only, group only, and joint phase/group.
- Physics coverage: isotropic and anisotropic modes.
- Initial-model coverage: `init_model_type=0/1/2`.
- Algorithm coverage: `optim_method=0/1`, `smooth_method=0/1`.
- Workflow coverage: forward only, inversion only, and forward+inversion loop.
- Geographic complexity coverage: flat-domain and topography+rotation scenarios.

## How to Run

Each testcase directory provides `run_this_test.sh`:

```bash
cd testcaseXX
bash run_this_test.sh
```

Note: scripts currently assume the SurfATT binaries are under:

- `SRUFATT_HOME=/Users/xumijian/Codes/SurfATTPP/bin`

If your local path is different, update `SRUFATT_HOME` in each testcase script before running.
