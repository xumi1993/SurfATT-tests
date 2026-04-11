import h5py
import numpy as np
from scipy.io import netcdf_file


def read_nc(fname):
    # NetCDF4 files are HDF5-based and can be read with h5py.
    # NetCDF classic files (e.g. CDF1/CDF2) are not HDF5 and need scipy.
    f = netcdf_file(fname, mode='r', mmap=False)
    try:
        vsv = np.asarray(f.variables['vsv'][:])
        vsh = np.asarray(f.variables['vsh'][:])
        x = np.asarray(f.variables['longitude'][:])
        y = np.asarray(f.variables['latitude'][:])
        z = np.asarray(f.variables['depth'][:])
        print(z)
    finally:
        f.close()

    vs = np.sqrt((2.0 * vsv**2 + vsh**2) / 3.0).T
    return x, y, z, vs


def write_h5(fname, x, y, z, vs):
    with h5py.File(fname, 'w') as f:
        f.create_dataset('x', data=x)
        f.create_dataset('y', data=y)
        f.create_dataset('z', data=z)
        f.create_dataset('vs', data=vs)


if __name__ == '__main__':
    # Read the original NetCDF file
    nc_file = 'csem.nc'
    x, y, z, vs = read_nc(nc_file)

    # Write to HDF5 file
    h5_file = 'csem.h5'
    write_h5(h5_file, x, y, z, vs)
