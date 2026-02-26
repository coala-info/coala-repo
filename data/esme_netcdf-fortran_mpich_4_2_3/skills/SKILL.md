---
name: esme_netcdf-fortran_mpich_4_2_3
description: This tool provides Fortran bindings for the NetCDF library optimized for parallel data access with MPICH. Use when user asks to compile Fortran programs with NetCDF, link against parallel NetCDF libraries, or manage array-oriented scientific datasets using MPI.
homepage: http://www.unidata.ucar.edu/software/netcdf/
---


# esme_netcdf-fortran_mpich_4_2_3

## Overview
This skill provides guidance for utilizing the `esme_netcdf-fortran_mpich_4_2_3` package, which provides the necessary Fortran bindings to the NetCDF library. This specific build is optimized for use with the MPICH implementation of the Message Passing Interface (MPI), enabling parallel data access. It is primarily used by researchers and developers in atmospheric and oceanic sciences to handle large-scale, array-oriented scientific datasets.

## Compilation and Linking
To compile Fortran programs using this library, you must ensure that the compiler can find the NetCDF module files and link against the correct shared objects.

### Environment Setup
Ensure the bioconda environment is active:
```bash
conda activate your_env_name
```

### Compiling with mpifort
Since this package is built with MPICH, use the `mpifort` wrapper to ensure MPI dependencies are handled:

```bash
# Compile and link in one step
mpifort my_script.f90 -o my_app -I$CONDA_PREFIX/include -L$CONDA_PREFIX/lib -lnetcdff -lnetcdf
```

- `-I$CONDA_PREFIX/include`: Points to the `.mod` files (e.g., `netcdf.mod`).
- `-lnetcdff`: Links the NetCDF-Fortran specific library.
- `-lnetcdf`: Links the underlying C library.

## Common CLI Patterns
While NetCDF-Fortran is primarily a programming interface, the package environment provides utility commands for checking configuration.

### Checking Configuration
Use `nf-config` to retrieve compiler flags and library locations automatically:

```bash
# Get all configuration details
nf-config --all

# Get only the Fortran compiler flags
nf-config --fflags

# Get the linking flags
nf-config --flibs
```

### Parallel Execution
To run a compiled program that utilizes parallel NetCDF features:

```bash
mpirun -np 4 ./my_app
```

## Best Practices
- **Module Usage**: Always include `use netcdf` at the beginning of your Fortran modules or programs to access the API.
- **Error Handling**: Check the return status of every NetCDF function call (e.g., `status = nf90_open(...)`). Use `nf90_strerror(status)` to print human-readable errors.
- **Parallel I/O**: When using parallel NetCDF, ensure you use the `NF90_MPIIO` or `NF90_MPIPOSIX` flags during file creation or opening to enable MPI-aware I/O.
- **Variable Definition**: Define dimensions and variables before entering "data mode." Use `nf90_enddef` to transition from "define mode" to "data mode."

## Reference documentation
- [NetCDF-Fortran Overview](./references/anaconda_org_channels_bioconda_packages_esme_netcdf-fortran_mpich_4_2_3_overview.md)
- [NetCDF Software Documentation](./references/www_unidata_ucar_edu_software_netcdf.md)