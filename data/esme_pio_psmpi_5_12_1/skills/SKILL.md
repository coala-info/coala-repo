---
name: esme_pio_psmpi_5_12_1
description: The ParallelIO (PIO) library provides a high-level interface for C and Fortran applications to perform parallel netCDF I/O.
homepage: https://github.com/NCAR/ParallelIO
---

# esme_pio_psmpi_5_12_1

## Overview
The ParallelIO (PIO) library provides a high-level interface for C and Fortran applications to perform parallel netCDF I/O. It is designed to solve the bottleneck of many processors writing to a single file by designating a subset of processors as "I/O nodes." This skill assists in the installation, configuration, and execution of PIO-based workflows, focusing on its two primary operational modes: Intracomm (where I/O processors also compute) and Async (where dedicated processors handle I/O tasks).

## Installation and Environment Setup
Install the package via Conda to ensure all MPI-linked dependencies are resolved:
```bash
conda install bioconda::esme_pio_psmpi_5_12_1
```

### Required Environment Variables
Before compiling applications against PIO, export the following variables to point to MPI-enabled compilers and dependent libraries (NetCDF, PnetCDF, HDF5):
- `CC`: Set to `mpicc`.
- `FC`: Set to `mpif90` or `mpifort`.
- `CPPFLAGS`: Include paths for NetCDF and PnetCDF headers (e.g., `-I$PREFIX/include`).
- `LDFLAGS`: Library paths for linking (e.g., `-L$PREFIX/lib`).

## Configuration and Building
PIO supports both Autotools and CMake. Use the following patterns for building from source or integrating into a build pipeline.

### Autotools Pattern
Use this for standard builds where Fortran support is required:
```bash
./configure --prefix=/path/to/install --enable-fortran
make
make check
make install
```

### CMake Pattern
Use CMake for modern builds or when specific features like timing or testing need to be toggled:
```bash
cmake -DPIO_BUILD_TESTS=ON \
      -DPIO_BUILD_TIMING=ON \
      -DNETCDF_DIR=$NETCDF_HOME \
      -DPNETCDF_DIR=$PNETCDF_HOME \
      /path/to/pio/source
make
```

## Operational Modes and Best Practices
Choose the appropriate I/O mode based on your application's computational profile:

### Intracomm Mode
- **When to use**: When memory is limited and you cannot afford to set aside idle processors for I/O.
- **Behavior**: A subset of processors is designated to perform I/O, but these processors also participate in the main computational work.

### Async Mode
- **When to use**: For large-scale simulations where I/O latency significantly impacts compute time.
- **Behavior**: Creates multiple computation components and one shared set of dedicated I/O processors. Write operations are performed asynchronously, allowing computation to continue while I/O processors interact with storage.

### Performance Tuning
- **Library Selection**: PIO can use NetCDF-4, NetCDF-3 (classic), or PnetCDF. Use PnetCDF for the best performance on classic netCDF files in parallel environments.
- **I/O Quotas**: Experiment with the number of I/O tasks. A common starting point is one I/O task per compute node or per storage target (OST).
- **Testing**: Always run `make check` after building to verify that the MPI environment and the underlying NetCDF/PnetCDF libraries are correctly handling parallel access.

## Reference documentation
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_esme_pio_psmpi_5_12_1_overview.md)
- [ParallelIO GitHub README](./references/github_com_NCAR_ParallelIO.md)
- [ParallelIO Wiki - Build Instructions](./references/github_com_NCAR_ParallelIO_wiki.md)