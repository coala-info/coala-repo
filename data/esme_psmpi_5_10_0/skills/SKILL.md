---
name: esme_psmpi_5_10_0
description: ESME manages the installation and compatibility of scientific computing libraries like netCDF, HDF5, and ESMF for climate simulations using ParaStationMPI. Use when user asks to verify environment health, locate bundled library headers, compile models with MPI-enabled libraries, or benchmark parallel interconnect performance.
homepage: https://github.com/j34ni/bioconda-recipes
---


# esme_psmpi_5_10_0

## Overview

The Earth System Modelling Environment (ESME) is a specialized meta-package designed to simplify the complex installation of scientific computing libraries required for climate simulations. It ensures version compatibility between critical components like netCDF, HDF5, and the Earth System Modeling Framework (ESMF) while providing native support for parallel execution via MPI. Use this skill to verify environment health, locate bundled library headers, and ensure that parallel I/O operations are correctly configured for the ParaStationMPI backend.

## Installation and Environment Setup

To deploy the environment, use the conda package manager:

```bash
conda install bioconda::esme_psmpi_5_10_0
```

### Verifying Bundled Components
After installation, confirm that the specific versions included in the 5.10.0 bundle are active:

*   **netCDF C (v4.9.2):** Run `nc-config --version`
*   **netCDF Fortran (v4.6.1):** Run `nf-config --version`
*   **HDF5 (v1.14.5):** Run `h5cc -showconfig`
*   **ESMF (v8.8.0):** Check the `$ESMF_MKFILE` environment variable or run `esmf_info`
*   **PnetCDF (v1.14.0):** Verify via `pnetcdf-config --version`

## Common CLI Patterns

### Compiling with Bundled Libraries
When compiling climate models or custom analysis tools within this environment, use the provided config utilities to ensure correct linking against the MPI-enabled libraries.

**For C-based tools:**
```bash
mpicc my_model.c $(nc-config --cflags --libs) -o my_model
```

**For Fortran-based models:**
```bash
mpif90 my_model.f90 $(nf-config --fflags --flibs) -o my_model
```

### Performance Benchmarking
The bundle includes the OSU Micro Benchmarks (v7.5). Use these to verify the performance of the ParaStationMPI interconnect:

```bash
# Example: Testing point-to-point latency
mpirun -np 2 osu_latency
```

## Expert Tips and Best Practices

*   **MPI Implementation:** While this bundle is optimized for ParaStationMPI, it is designed to facilitate management across multiple MPI implementations. Always ensure your `LD_LIBRARY_PATH` points to the specific MPI implementation intended for your cluster hardware.
*   **Parallel I/O (ParallelIO v2.6.5):** When using the ParallelIO (PIO) library included in this bundle, ensure your netCDF files are created with the `NC_NETCDF4` or `NC_PNETCDF` flags to take advantage of the underlying HDF5 and PnetCDF parallel optimizations.
*   **ESMF Environment:** For complex models requiring the Earth System Modeling Framework, always source the `ESMF_MKFILE`. This file contains all the necessary compiler flags and library paths required to link against the ESMF v8.8.0 build included in ESME.
*   **Library Conflicts:** Avoid installing standalone versions of netCDF or HDF5 in the same environment as `esme_psmpi_5_10_0` to prevent symbol conflicts and ensure the MPI-linked versions are used.

## Reference documentation

- [esme_psmpi_5_10_0 - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_esme_psmpi_5_10_0_overview.md)