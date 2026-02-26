---
name: esme_mpich_4_3_1
description: ESME provides a consistent foundation of high-performance computing libraries, including NetCDF, HDF5, and ParallelIO, compiled against MPICH 4.3.1 for climate modeling. Use when user asks to compile climate models, run MPI-based simulations, or verify parallel I/O performance using OSU Micro Benchmarks.
homepage: https://github.com/j34ni/bioconda-recipes
---


# esme_mpich_4_3_1

## Overview
The Earth System Modelling Environment (ESME) is a specialized metapackage designed to provide a consistent and stable foundation for climate modeling. It bundles critical high-performance computing (HPC) libraries—including NetCDF (C and Fortran), HDF5, ParallelIO, and ESMF—ensuring they are all compiled against the same MPICH 4.3.1 implementation. This eliminates common compatibility issues between parallel I/O libraries and the underlying MPI layer in scientific workflows.

## Installation and Environment Setup
To ensure all bundled libraries are correctly linked, always install ESME into a clean conda environment:

```bash
conda create -n esme_env bioconda::esme_mpich_4_3_1
conda activate esme_env
```

## Compiling Climate Models
When building models (like WRF, CESM, or localized kernels) against this bundle, use the provided configuration utilities to retrieve the correct compiler flags and library paths.

### NetCDF Integration
For C-based components:
```bash
nc-config --all
```

For Fortran-based climate models (most common):
```bash
nf-config --all
```

### HDF5 and Parallel I/O
Since ESME uses HDF5 1.14.6 and PnetCDF 1.14.1, ensure your Makefile references the parallel-enabled wrappers:
- Use `h5pcc` for parallel C compilation.
- Use `h5pfc` for parallel Fortran compilation.

## Running MPI Jobs
Execute simulations using the MPICH-specific process manager included in the bundle.

### Basic Execution
```bash
mpirun -np <number_of_processes> ./your_model_executable
```

### Binding and Affinity
For climate models sensitive to memory bandwidth, use MPICH binding options:
```bash
mpirun -np 16 --bind-to core --map-by socket ./your_model_executable
```

## Performance Validation
ESME includes the OSU Micro Benchmarks (v7.5.1) to verify that the MPI environment is performing optimally before starting long-running simulations.

### Testing Latency
```bash
mpirun -np 2 osu_latency
```

### Testing Aggregate Bandwidth
```bash
mpirun -np 2 osu_biband
```

## Expert Tips
- **Library Pathing**: If your model fails to find `libnetcdff.so` at runtime, ensure your `LD_LIBRARY_PATH` includes `$CONDA_PREFIX/lib`.
- **ParallelIO (PIO)**: This bundle includes PIO v2.6.6. When configuring your model, point the PIO path to the conda environment root to leverage optimized parallel I/O across NetCDF and PnetCDF.
- **Version Consistency**: Do not mix this package with `openmpi` or other MPI providers in the same environment, as it will cause symbol collisions in the NetCDF/HDF5 layers.

## Reference documentation
- [esme_mpich_4_3_1 - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_esme_mpich_4_3_1_overview.md)