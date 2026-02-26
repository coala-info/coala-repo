---
name: esme_pio_mpich_4_3_1
description: This tool provides a high-level interface for managing complex parallel I/O patterns in Earth system models by abstracting MPI-IO, NetCDF, and PnetCDF calls. Use when user asks to manage parallel data storage, optimize I/O performance in structured grid applications, or configure asynchronous data writing to prevent disk bottlenecks.
homepage: https://github.com/NCAR/ParallelIO
---


# esme_pio_mpich_4_3_1

## Overview
The `esme_pio_mpich_4_3_1` package provides the ParallelIO (PIO) library, a high-level interface designed to manage complex parallel I/O patterns in Earth system models and other structured grid applications. It abstracts the underlying MPI-IO, NetCDF, or PnetCDF calls, allowing you to designate specific subsets of processors for I/O tasks. This prevents the "bottleneck" effect where every processor attempts to write to disk simultaneously, instead funneling data through optimized I/O nodes.

## Installation and Environment Setup
To use this specific build within a Conda environment:

```bash
conda install bioconda::esme_pio_mpich_4_3_1
```

### Required Environment Variables
When compiling applications against this library, ensure your environment is configured to use the matching MPI wrappers:

*   `CC`: Should be set to `mpicc`
*   `FC`: Should be set to `mpifort` or `mpif90`
*   `CPPFLAGS`: Include the paths to NetCDF and PnetCDF headers if they are not in standard paths.
*   `LDFLAGS`: Include the paths to NetCDF, HDF5, and PnetCDF libraries.

## Common Build and Configuration Patterns

### Building Applications with Autotools
If your application uses a configure script to link against PIO, use the following pattern:

```bash
export CC=mpicc
export FC=mpifort
export CPPFLAGS="-I$PREFIX/include"
export LDFLAGS="-L$PREFIX/lib"
./configure --prefix=/path/to/install --enable-fortran
make
make check
make install
```

### Building Applications with CMake
For modern HPC workflows, PIO is typically integrated via CMake:

```bash
CC=mpicc FC=mpif90 cmake \
  -DPIO_BUILD_TESTS=ON \
  -DPIO_BUILD_TIMING=ON \
  -DNETCDF_DIR=$NETCDF_HOME \
  -DPNETCDF_DIR=$PNETCDF_HOME \
  /path/to/your/source
```

## Operational Modes
PIO supports two primary modes of operation that you must define in your application code:

1.  **Intracomm Mode**: A subset of the computational processors is designated to perform I/O. These processors perform both computation and storage interaction.
2.  **Async Mode**: Creates distinct components. One set of processors is dedicated solely to I/O, while others perform computation. Computational components send data to the I/O component asynchronously, allowing the simulation to continue while data is being written to disk.

## Expert Tips and Best Practices
*   **Compiler Consistency**: Ensure that the entire stack (HDF5, NetCDF, PnetCDF, and PIO) is built with the exact same version of MPICH (4.3.1) and the same C/Fortran compilers to avoid ABI incompatibilities.
*   **NetCDF-4 Parallel Support**: PIO requires the underlying NetCDF C library to be built with MPI support (linked against an MPI-enabled HDF5). If you encounter errors during `make check`, verify that `nc-config --has-parallel` returns `yes`.
*   **Large DOF Handling**: For very large Degrees of Freedom (DOF) on high-core counts (e.g., >5000 tasks), monitor for "large DOF" errors. Ensure your `iotasks` and `stride` settings in the PIO init call are tuned to your HPC fabric's striping capabilities.
*   **Debugging**: Use the `libpio.settings` file generated during the build to verify which features (NetCDF-4, PnetCDF, Fortran) were successfully enabled in the library.

## Reference documentation
- [ParallelIO GitHub Repository](./references/github_com_NCAR_ParallelIO.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_esme_pio_mpich_4_3_1_overview.md)
- [ParallelIO Wiki and Build Instructions](./references/github_com_NCAR_ParallelIO_wiki.md)