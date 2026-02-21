---
name: esme_pio_openmpi_5_0_7
description: The `esme_pio_openmpi_5_0_7` package provides the ParallelIO (PIO) library, a high-level interface designed to simplify the complexities of parallel I/O in scientific simulations.
homepage: https://github.com/NCAR/ParallelIO
---

# esme_pio_openmpi_5_0_7

## Overview

The `esme_pio_openmpi_5_0_7` package provides the ParallelIO (PIO) library, a high-level interface designed to simplify the complexities of parallel I/O in scientific simulations. It allows applications to perform I/O through a netCDF-like API while transparently managing the distribution of data across a subset of processors. This specific build is optimized for environments using OpenMPI 5.0.7 and is essential for climate, weather, and other structured grid models that need to scale I/O performance alongside computational tasks.

## Installation and Environment Setup

To install the package using Conda:

```bash
conda install bioconda::esme_pio_openmpi_5_0_7
```

### Linking the Library

When compiling applications against this library, ensure your environment variables point to the correct include and library paths provided by the Conda environment:

```bash
export CC=mpicc
export FC=mpifort
export CPPFLAGS="-I$CONDA_PREFIX/include"
export LDFLAGS="-L$CONDA_PREFIX/lib -Wl,-rpath,$CONDA_PREFIX/lib"
export LIBS="-lpio -lnetcdf -lpnetcdf"
```

## Core Operational Modes

PIO supports two primary modes of operation that dictate how I/O tasks are distributed:

1.  **Intracomm Mode**: A subset of the computational processors is designated to perform I/O. These processors participate in both computation and storage interaction. This is the most common configuration for standard HPC workloads.
2.  **Async Mode**: Computational components perform write operations asynchronously. A dedicated set of I/O processors handles all storage interactions, allowing the computational tasks to proceed without waiting for I/O completion.

## Best Practices for Parallel I/O

### 1. Processor Decomposition
For optimal performance, carefully choose the number of I/O tasks (`iotasks`). A common heuristic is to use one I/O task per compute node or per file system OST (Object Storage Target), depending on the underlying architecture (e.g., Lustre).

### 2. Library Dependencies
PIO relies on underlying libraries for actual data movement. Ensure your workflow accounts for:
- **NetCDF-C**: Required for standard netCDF I/O.
- **PnetCDF**: Optional but recommended for high-performance parallel I/O on classic netCDF formats.
- **HDF5**: Required if using netCDF-4/HDF5 formats.

### 3. Configuration via Autotools/CMake
If building from source or integrating into a larger build system, use the following patterns:

**Autotools Pattern:**
```bash
./configure --enable-fortran --prefix=/path/to/install CC=mpicc FC=mpif90
make check
make install
```

**CMake Pattern:**
```bash
cmake -DPIO_BUILD_TESTS=ON -DPIO_BUILD_TIMING=ON /path/to/pio/source
make
```

## Troubleshooting Common Issues

- **MPI Version Mismatch**: Ensure that the MPI wrapper used for compilation (`mpicc`/`mpifort`) matches the OpenMPI 5.0.7 version provided in the package to avoid symbol errors.
- **Missing NetCDF-4 Features**: If netCDF-4 features are required, verify that the linked NetCDF C library was built with MPI and HDF5 support.
- **Large Dataset Errors**: For datasets exceeding 2GB, ensure you are using the `64BIT_OFFSET` or `NETCDF4` file formats to avoid integer overflow issues in the underlying libraries.

## Reference documentation
- [ParallelIO Overview](./references/github_com_NCAR_ParallelIO.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_esme_pio_openmpi_5_0_7_overview.md)
- [PIO Wiki and Build Scripts](./references/github_com_NCAR_ParallelIO_wiki.md)