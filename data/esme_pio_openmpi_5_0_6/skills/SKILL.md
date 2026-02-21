---
name: esme_pio_openmpi_5_0_6
description: The `esme_pio_openmpi_5_0_6` package provides the ParallelIO (PIO) library, a specialized interface for high-performance computing (HPC) environments.
homepage: https://github.com/NCAR/ParallelIO
---

# esme_pio_openmpi_5_0_6

## Overview

The `esme_pio_openmpi_5_0_6` package provides the ParallelIO (PIO) library, a specialized interface for high-performance computing (HPC) environments. It allows applications to perform parallel I/O operations without requiring every processor to interact directly with the storage system. By offloading I/O tasks to a designated subset of processors, PIO minimizes synchronization overhead and prevents the I/O bottlenecks common in large-scale simulations. It supports both C and Fortran and acts as a high-level wrapper for NetCDF and PnetCDF.

## Installation and Environment Setup

To install the package using Conda:

```bash
conda install bioconda::esme_pio_openmpi_5_0_6
```

### Compiler Configuration
When building applications against this library, ensure your environment uses the matching MPI wrappers:

- **C Compiler**: `mpicc`
- **Fortran Compiler**: `mpif90` or `mpifort`

## Operational Modes

PIO operates in two primary modes. Choosing the correct mode is critical for performance:

1.  **Intracomm Mode**: A subset of processors is designated to perform I/O, but these same processors also participate in computational work. This is generally easier to implement for existing codes.
2.  **Async Mode**: Creates distinct components for computation and I/O. Computational components perform write operations asynchronously, while a dedicated set of I/O processors handles storage interaction. This is preferred for very large-scale runs where I/O latency significantly impacts compute time.

## Building Applications with PIO

When compiling your application, you must point to the include and library directories provided by the Conda environment.

### Common Flags
- **Include**: `-I$CONDA_PREFIX/include`
- **Linking**: `-L$CONDA_PREFIX/lib -lpio -lnetcdf -lpnetcdf`

### Configuration Best Practices
If you are building PIO from source or configuring a project that depends on it, use the following patterns:

**Using Autotools:**
```bash
export CC=mpicc
export FC=mpifort
export CPPFLAGS="-I$CONDA_PREFIX/include"
export LDFLAGS="-L$CONDA_PREFIX/lib"
./configure --prefix=/path/to/install --enable-fortran
```

**Using CMake:**
```bash
CC=mpicc FC=mpif90 cmake -DPIO_BUILD_TESTS=ON -DPIO_BUILD_TIMING=ON /path/to/pio/source
```

## Expert Tips for Performance

- **I/O Quotas**: For structured grids, align your I/O task count with the physical layout of your storage system (e.g., Lustre OSTs) to maximize bandwidth.
- **NetCDF-4 vs Classic**: While PIO supports NetCDF-4 (HDF5-based), classic NetCDF or PnetCDF formats often provide better performance for raw throughput in parallel environments.
- **Memory Overhead**: In Async mode, ensure the dedicated I/O nodes have sufficient memory to buffer incoming data from the compute nodes before flushing to disk.

## Reference documentation
- [ParallelIO Overview](./references/anaconda_org_channels_bioconda_packages_esme_pio_openmpi_5_0_6_overview.md)
- [NCAR ParallelIO GitHub Repository](./references/github_com_NCAR_ParallelIO.md)
- [ParallelIO Wiki and Build Instructions](./references/github_com_NCAR_ParallelIO_wiki.md)