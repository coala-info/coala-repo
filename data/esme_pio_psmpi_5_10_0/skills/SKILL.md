---
name: esme_pio_psmpi_5_10_0
description: This tool provides a high-level interface for scalable parallel I/O on high-performance computing systems using the ParallelIO library. Use when user asks to optimize data throughput, configure asynchronous I/O modes, or build applications with NetCDF and PnetCDF support using PSMPI.
homepage: https://github.com/NCAR/ParallelIO
metadata:
  docker_image: "quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0"
---

# esme_pio_psmpi_5_10_0

## Overview

The `esme_pio_psmpi_5_10_0` skill provides guidance for utilizing the ParallelIO (PIO) library, a high-level C and Fortran interface designed for scalable I/O on high-performance computing systems. PIO optimizes data throughput by allowing applications to designate a specific subset of processors to handle I/O tasks, preventing the "bottleneck" effect common when all computational nodes attempt to write to storage simultaneously. It supports both synchronous (Intracomm) and asynchronous (Async) I/O modes and serves as a wrapper for NetCDF and PnetCDF.

## Installation and Environment Setup

To install the package via Conda:
```bash
conda install bioconda::esme_pio_psmpi_5_10_0
```

### Required Dependencies
Ensure the following libraries are available in your environment, as PIO relies on them for underlying storage operations:
- **NetCDF-C**: Version 4.6.1+ (Must be built with MPI support).
- **PnetCDF**: Version 1.9.0+ (Optional but recommended for parallel performance).
- **HDF5**: Must be the MPI-enabled version.
- **MPI**: Specifically PSMPI for this build.

## Build and Configuration Patterns

### Autotools Configuration
When building applications against PIO using the autotools suite, explicitly define your MPI compilers and dependency paths:

```bash
export CC=mpicc
export FC=mpifort
export CPPFLAGS="-I$NETCDF_PATH/include -I$PNETCDF_PATH/include"
export LDFLAGS="-L$NETCDF_PATH/lib -L$PNETCDF_PATH/lib"

./configure --prefix=/path/to/install --enable-fortran
make check
make install
```

### CMake Configuration
For modern build systems, use the following pattern to initialize the PIO build:

```bash
CC=mpicc FC=mpif90 cmake -DPIO_BUILD_TESTS=ON -DPIO_BUILD_TIMING=ON /path/to/pio/source
make
```

## Operational Best Practices

### Selecting the I/O Mode
- **Intracomm Mode**: Use this when I/O processors should also participate in computational work. This is the standard mode for most structured grid applications where memory is a primary constraint.
- **Async Mode**: Use this for maximum performance in very large-scale simulations. It creates a dedicated set of I/O processors that handle storage interaction while the computational components continue processing.

### Performance Tuning
- **Processor Subsets**: Do not assign all processors to I/O. Performance typically peaks when a small fraction (e.g., 1/16th or 1/32nd) of total processors are designated as I/O nodes.
- **Library Linking**: Ensure that the entire stack (HDF5, NetCDF, PnetCDF, and PIO) is built with the same MPI compiler (PSMPI) to avoid symbol conflicts and segmentation faults.
- **NetCDF-4 Features**: If using NetCDF-4 features (like compression), ensure HDF5 is linked correctly, though be aware that parallel compression can impact write speeds.

## Reference documentation
- [ParallelIO Overview](./references/anaconda_org_channels_bioconda_packages_esme_pio_psmpi_5_10_0_overview.md)
- [NCAR ParallelIO GitHub Repository](./references/github_com_NCAR_ParallelIO.md)
- [ParallelIO Wiki and Build Instructions](./references/github_com_NCAR_ParallelIO_wiki.md)