---
name: esme_mpich_4_2_3
description: ESME provides a validated bundle of libraries and tools for climate modeling and high-performance computing using the MPICH MPI implementation. Use when user asks to deploy scientific computing stacks, manage climate modeling dependencies, verify MPI environments, or utilize libraries like ESMF, netCDF, and ParallelIO.
homepage: https://github.com/j34ni/bioconda-recipes
metadata:
  docker_image: "quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0"
---

# esme_mpich_4_2_3

## Overview
The Earth System Modelling Environment (ESME) is a specialized meta-package designed to simplify the deployment of complex scientific computing stacks. It provides a validated bundle of libraries essential for climate modeling, ensuring that high-level frameworks like ESMF and ParallelIO are perfectly compatible with underlying data formats (netCDF/HDF5) and the MPICH MPI implementation. This skill helps in managing these dependencies and utilizing the bundled tools for high-performance computing tasks.

## Installation and Environment Setup
To deploy the environment, use the bioconda channel:

```bash
conda install bioconda::esme_mpich_4_2_3
```

Once installed, all constituent libraries are added to the standard environment paths (`PATH`, `LD_LIBRARY_PATH`, `CPATH`).

## Included Components and Versions
This bundle provides the following specific versions. Use these for compatibility checks with model source code:
- **MPI Implementation**: MPICH
- **Data Formats**: HDF5 (1.14.5), netCDF-C (4.9.2), netCDF-Fortran (4.6.1)
- **Parallel I/O**: PnetCDF (1.14.0), ParallelIO (2.6.2)
- **Modeling Framework**: ESMF (8.8.0)
- **Performance Testing**: OSU Micro Benchmarks (7.5)

## Common CLI Patterns and Verification

### 1. Verifying the MPI Environment
Ensure the MPICH wrappers are active and pointing to the correct installation:
```bash
mpicc --version
mpifort --version
which mpirun
```

### 2. Checking Library Configuration
Use the provided config tools to retrieve compiler flags and library paths for manual Makefile configuration:
```bash
# For netCDF-C
nc-config --all

# For netCDF-Fortran
nf-config --all

# For HDF5
h5cc -config
```

### 3. Validating ESMF Installation
The Earth System Modeling Framework (ESMF) provides a utility to verify its build configuration and capabilities:
```bash
esmf_printready
```

### 4. Performance Benchmarking
To verify the MPI interconnect performance within the ESME environment, run the bundled OSU Micro Benchmarks (typically found in the environment's `libexec` or `bin` directory):
```bash
# Example: Running a point-to-point latency test
mpirun -np 2 osu_latency
```

## Best Practices
- **Compiler Consistency**: Always use the MPI wrappers (`mpicc`, `mpifort`, `mpicxx`) provided by the environment rather than direct calls to `gcc` or `gfortran` to ensure correct linking against the ESME stack.
- **Parallel I/O**: When configuring climate models (like CESM or E3SM), point the ParallelIO (PIO) configuration to the PnetCDF and netCDF paths provided by this package to leverage the pre-built parallel optimizations.
- **Fortran Modules**: Ensure your `FFLAGS` include the path to the netCDF-Fortran `.mod` files, which are standard in the conda environment's `include` directory.

## Reference documentation
- [esme_mpich_4_2_3 Overview](./references/anaconda_org_channels_bioconda_packages_esme_mpich_4_2_3_overview.md)