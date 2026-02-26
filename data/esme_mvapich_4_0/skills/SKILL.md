---
name: esme_mvapich_4_0
description: This tool provides a curated bundle of high-performance computing libraries and climate science software optimized for the MVAPICH MPI implementation. Use when user asks to verify library installations, check netCDF or ESMF configurations, and run MPI performance benchmarks.
homepage: https://github.com/j34ni/bioconda-recipes
---


# esme_mvapich_4_0

## Overview

The Earth System Modelling Environment (ESME) is a specialized metapackage designed to eliminate the "dependency hell" often encountered in climate science software stacks. This specific version, `esme_mvapich_4_0`, provides a curated bundle of high-performance computing (HPC) libraries—including netCDF (C and Fortran), HDF5, PnetCDF, ParallelIO, and ESMF—all compiled and linked to work seamlessly with the MVAPICH MPI implementation. Use this skill to verify installations, check library configurations, and run performance benchmarks within this environment.

## Installation and Environment Setup

Install the bundle using the bioconda channel. It is highly recommended to use a dedicated conda environment to avoid conflicts with other MPI implementations (like OpenMPI or MPICH).

```bash
# Create a new environment and install the ESME bundle
conda create -n climate_env bioconda::esme_mvapich_4_0
conda activate climate_env
```

## Verifying the Component Stack

Since ESME is a bundle, verify the presence and versions of the individual core components to ensure the environment is correctly initialized.

### 1. netCDF Configuration
Check the C and Fortran interfaces, which are critical for climate model compilation.
```bash
# Check netCDF-C configuration and linked libraries
nc-config --all

# Check netCDF-Fortran configuration (essential for models like WRF or CESM)
nf-config --all
```

### 2. HDF5 Verification
Ensure the underlying data management layer is responsive.
```bash
h5dump --version
h5cc -showconfig
```

### 3. ESMF (Earth System Modeling Framework)
Verify the ESMF installation, which handles the coupling of different model components.
```bash
esmf_info
```

## Running Performance Benchmarks

The bundle includes the OSU Micro Benchmarks (Version 7.5.1) to test the efficiency of the MVAPICH interconnect.

### Point-to-Point Latency
Test the basic communication overhead between two nodes.
```bash
mpirun -np 2 osu_latency
```

### Bandwidth Test
Measure the data throughput capacity of the MPI environment.
```bash
mpirun -np 2 osu_bw
```

### Collective Communication
Test the performance of operations like `MPI_Allreduce`, which are frequent in climate simulations.
```bash
mpirun -np 4 osu_allreduce
```

## Expert Tips and Best Practices

- **MPI Consistency**: Never mix libraries from this bundle with MPI wrappers (mpicc, mpifort) from a different MPI implementation (e.g., OpenMPI). The `esme_mvapich_4_0` bundle is strictly tied to MVAPICH.
- **Compiler Flags**: When compiling model source code against this stack, use `nf-config --fflags` and `nf-config --flibs` to dynamically retrieve the correct include paths and library links.
- **Parallel I/O**: For models requiring high-performance I/O, utilize the included `ParallelIO` (PIO) library and `PnetCDF` rather than standard netCDF to take advantage of the MVAPICH-optimized parallel file system access.
- **Architecture Support**: This bundle is optimized for `linux-64` and `linux-aarch64` platforms. Ensure the target HPC architecture matches these supported platforms.

## Reference documentation
- [ESME MVAPICH 4.0 Overview](./references/anaconda_org_channels_bioconda_packages_esme_mvapich_4_0_overview.md)