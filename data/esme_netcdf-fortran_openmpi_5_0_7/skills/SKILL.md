---
name: esme_netcdf-fortran_openmpi_5_0_7
description: This skill provides technical guidance for utilizing the NetCDF-Fortran interface within an OpenMPI 5.0.7 framework.
homepage: http://www.unidata.ucar.edu/software/netcdf/
---

# esme_netcdf-fortran_openmpi_5_0_7

## Overview
This skill provides technical guidance for utilizing the NetCDF-Fortran interface within an OpenMPI 5.0.7 framework. It focuses on the practical application of the `esme_netcdf-fortran_openmpi_5_0_7` package, which enables Fortran programs to handle self-describing, machine-independent scientific data. This build is specifically tailored for high-performance computing (HPC) environments where parallel I/O and MPI communication are required for processing large-scale array-oriented datasets.

## Compilation and Linking Patterns
When working with this specific build, always use the MPI-wrapped Fortran compiler to ensure proper alignment with the OpenMPI 5.0.7 libraries.

### Retrieving Configuration Flags
The `nf-config` utility is the primary tool for identifying the correct include paths and library locations.
- To get compilation flags (include paths): `nf-config --fflags`
- To get linking flags (library paths and names): `nf-config --flibs`

### Standard Compilation Command
Use `mpifort` to compile and link your source code. A typical pattern looks like:
`mpifort my_model.f90 -o my_model $(nf-config --fflags) $(nf-config --flibs)`

## Best Practices for Parallel I/O
Since this package is linked with OpenMPI, it supports parallel access to NetCDF files (NetCDF-4/HDF5).

1.  **Module Usage**: Always include `use netcdf` at the start of your Fortran modules.
2.  **Parallel Open**: When opening a file for parallel access, use the `nf90_open` or `nf90_create` functions with the MPI communicator (usually `MPI_COMM_WORLD`) and an MPI info object.
3.  **Collective vs. Independent**: Explicitly set the variable access mode to `nf90_collective` for better performance on large datasets across multiple MPI ranks, or `nf90_independent` for specific rank-based writes.
4.  **Error Handling**: Always check the return status of NetCDF functions (e.g., `status = nf90_open(...)`) and use `nf90_strerror(status)` to debug MPI-related I/O failures.

## Environment Setup
Ensure your environment is correctly configured to find the shared libraries at runtime:
- Verify that the `LD_LIBRARY_PATH` includes the directory containing `libnetcdff.so`.
- If using Conda, ensure the environment is active so that the `nf-config` in the path points to the version associated with OpenMPI 5.0.7.

## Reference documentation
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_esme_netcdf-fortran_openmpi_5_0_7_overview.md)
- [NetCDF Software Documentation](./references/www_unidata_ucar_edu_software_netcdf.md)