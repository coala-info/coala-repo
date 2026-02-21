---
name: esme_pio_mvapich_4_0_ofi
description: The ParallelIO (PIO) library is a high-level interface designed to simplify and optimize I/O operations for scientific applications running on large numbers of processors.
homepage: https://github.com/NCAR/ParallelIO
---

# esme_pio_mvapich_4_0_ofi

## Overview

The ParallelIO (PIO) library is a high-level interface designed to simplify and optimize I/O operations for scientific applications running on large numbers of processors. It provides a netCDF-like API that allows applications to distribute I/O tasks across a subset of available processors, effectively mitigating the "I/O bottleneck" common in massive parallel simulations. This specific build is tailored for environments utilizing MVAPICH 4.0 and the OFI network layer, ensuring high-performance data movement on modern interconnects.

## Installation and Environment Setup

To install the pre-compiled package via Conda:

```bash
conda install bioconda::esme_pio_mvapich_4_0_ofi
```

### Required Dependencies
Ensure the following libraries are available and built with the same MPI compilers (MVAPICH 4.0):
- **NetCDF-C**: Version 4.6.1+ (Required, must be MPI-enabled)
- **PnetCDF**: Version 1.9.0+ (Optional, but recommended for high-performance parallel I/O)
- **HDF5**: Must be linked with the MPI-enabled version used by NetCDF.

## Configuration and Building

When building PIO from source or integrating it into a larger project, use the following patterns.

### Autotools Configuration
Set the MPI compiler wrappers explicitly to ensure the OFI-enabled MVAPICH is used:

```bash
export CC=mpicc
export FC=mpifort
export CPPFLAGS="-I${NETCDF_PATH}/include -I${PNETCDF_PATH}/include"
export LDFLAGS="-L${NETCDF_PATH}/lib -L${PNETCDF_PATH}/lib"

./configure --prefix=/path/to/install --enable-fortran
make
make check
make install
```

### CMake Configuration
For modern build systems, CMake is the preferred method:

```bash
CC=mpicc FC=mpif90 cmake \
  -DPIO_BUILD_TESTS=ON \
  -DPIO_BUILD_FORTRAN=ON \
  -DNETCDF_DIR=$NETCDF_ROOT \
  -DPNETCDF_DIR=$PNETCDF_ROOT \
  /path/to/pio/source
```

## Operational Modes

PIO supports two primary modes of operation. Choosing the right one is critical for performance:

1.  **Intracomm Mode**:
    *   **Usage**: A subset of the application's processors are designated to perform I/O.
    *   **Behavior**: These I/O processors also participate in computational work.
    *   **Best for**: Applications where memory is tight and processors cannot be spared solely for I/O.

2.  **Async Mode**:
    *   **Usage**: Dedicated I/O processors are set aside.
    *   **Behavior**: Computational components perform write operations asynchronously; the dedicated I/O processors handle storage interaction in the background.
    *   **Best for**: Large-scale runs where I/O latency significantly impacts computational throughput.

## Expert Tips and Best Practices

- **Compiler Consistency**: Always build PIO and all its dependencies (HDF5, NetCDF, PnetCDF) using the exact same MVAPICH/OFI compiler wrappers to avoid symbol mismatches or MPI-layer instabilities.
- **Large Dataset Handling**: If encountering errors with datasets exceeding 2GB, ensure PIO is built with NetCDF-4 or PnetCDF support, as standard classic netCDF has file size limitations.
- **OFI Tuning**: When running on OFI-enabled fabrics, use the `FI_PROVIDER` environment variable to ensure MVAPICH is using the optimal provider for your hardware (e.g., `verbs`, `psm2`, or `efa`).
- **Fortran Integration**: If using the Fortran interface, ensure the `genf90` and `CMake_Fortran_utils` tools are available in your build environment, as PIO relies on them for code generation.

## Reference documentation
- [ParallelIO GitHub Repository](./references/github_com_NCAR_ParallelIO.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_esme_pio_mvapich_4_0_ofi_overview.md)
- [ParallelIO Wiki and Build Scripts](./references/github_com_NCAR_ParallelIO_wiki.md)