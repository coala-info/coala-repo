---
name: esme_pio_mvapich_4_0
description: The ParallelIO (PIO) library provides a high-level interface for C and Fortran applications to perform scalable parallel I/O.
homepage: https://github.com/NCAR/ParallelIO
---

# esme_pio_mvapich_4_0

## Overview

The ParallelIO (PIO) library provides a high-level interface for C and Fortran applications to perform scalable parallel I/O. It acts as a wrapper around netCDF and PnetCDF, allowing users to delegate I/O tasks to a specific subset of processors, thereby reducing the bottleneck typically associated with large-scale data writes. This specific package is tailored for environments utilizing the MVAPICH MPI implementation. Use this skill to manage the build process, configure I/O modes (Intracomm vs. Async), and ensure correct linking with mandatory dependencies like HDF5 and NetCDF.

## Installation and Environment Setup

### Conda Installation
To install the pre-compiled package within a Bioconda-enabled environment:
```bash
conda install bioconda::esme_pio_mvapich_4_0
```

### Compiler Requirements
When building from source or linking against this library, ensure your environment uses MPI-wrapped compilers. The library is sensitive to the underlying MPI implementation (MVAPICH).
- Set `CC=mpicc` and `FC=mpif90` (or `mpifort`).
- Ensure all dependent libraries (NetCDF, PnetCDF, HDF5) were built with the same MPI compilers to prevent symbol mismatches.

## Build Configuration Patterns

### Autotools (Standard Build)
For traditional builds, use the `configure` script. Enabling Fortran is usually required for Earth system models.
```bash
export CPPFLAGS="-I${NETCDF_PATH}/include -I${PNETCDF_PATH}/include"
export LDFLAGS="-L${NETCDF_PATH}/lib -L${PNETCDF_PATH}/lib"
./configure --prefix=/path/to/install --enable-fortran
make check
make install
```

### CMake (Modern Build)
For newer versions or integration into CMake-based projects:
```bash
cmake -DPIO_BUILD_TESTS=ON \
      -DPIO_BUILD_TIMING=ON \
      -DNETCDF_DIR=$NETCDF_ROOT \
      -DPNETCDF_DIR=$PNETCDF_ROOT \
      /path/to/pio/source
make
```

## Operational Modes and Best Practices

### Choosing an I/O Mode
- **Intracomm Mode**: Use this when I/O processors should also participate in computational work. This is the simplest configuration and is suitable for smaller scales or when memory is constrained.
- **Async Mode**: Use this for large-scale HPC runs. It creates a shared set of dedicated I/O processors. Computational components perform writes asynchronously, allowing the simulation to continue while the I/O processors handle storage interaction.

### Performance Tuning
- **Processor Subsets**: Always designate a subset of processors for I/O rather than using all processors. A common heuristic is to start with one I/O node per 10-20 compute nodes and adjust based on throughput.
- **NetCDF-4 vs. Classic**: If using NetCDF-4 features (like compression), ensure the NetCDF C library was built with HDF5 support.
- **PnetCDF**: For high-performance raw data throughput on parallel file systems (like Lustre or GPFS), prioritize the PnetCDF backend by ensuring it is linked during the build phase.

## Troubleshooting Common Issues
- **SZIP Support**: If errors occur regarding SZIP, verify if HDF5 was built with SZIP support and ensure `-lsz` is included in `LDFLAGS`.
- **Large DOF Errors**: For runs with more than 5120 tasks or very large Degrees of Freedom (DOF), ensure you are using the latest patch version (2.6.x+), as earlier versions had known bugs with large task counts.
- **MPI-IO Consistency**: Ensure the underlying file system supports MPI-IO atomicity if using multiple computational components in Async mode.

## Reference documentation
- [esme_pio_mvapich_4_0 Overview](./references/anaconda_org_channels_bioconda_packages_esme_pio_mvapich_4_0_overview.md)
- [NCAR ParallelIO GitHub Repository](./references/github_com_NCAR_ParallelIO.md)
- [ParallelIO Wiki](./references/github_com_NCAR_ParallelIO_wiki.md)