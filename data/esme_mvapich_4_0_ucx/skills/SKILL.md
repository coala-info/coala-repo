---
name: esme_mvapich_4_0_ucx
description: This package provides a pre-configured Earth System Modelling Environment optimized for high-performance climate simulations using MVAPICH 4.0 and UCX. Use when user asks to install a bundle of scientific libraries like netCDF and ESMF, perform parallel I/O for climate models, or run MPI performance benchmarks.
homepage: https://github.com/j34ni/bioconda-recipes
---


# esme_mvapich_4_0_ucx

## Overview
The `esme_mvapich_4_0_ucx` package provides a pre-configured Earth System Modelling Environment (ESME). It is designed to solve the "dependency hell" often encountered when building climate models by providing a binary-compatible bundle of essential scientific libraries. This specific version is optimized for the MVAPICH 4.0 MPI implementation using the UCX (Unified Communication X) framework, ensuring high-performance data I/O and inter-node communication for distributed simulations.

## Installation and Environment Setup
To install the bundle into a Conda environment, use:
`conda install bioconda::esme_mvapich_4_0_ucx`

After installation, verify that the environment prefix is correctly set in your `PATH` so that the bundled versions of compilers and utilities take precedence over system defaults.

## Library Verification and Configuration
Since this is a bundle of multiple tools, verify the specific versions to ensure compatibility with your model source code:

- **netCDF-C (v4.9.3)**: Use `nc-config --all` to see compiler flags and enabled features (like DAP or HDF5 support).
- **netCDF-Fortran (v4.6.2)**: Use `nf-config --all` for Fortran-specific linking instructions.
- **HDF5 (v1.14.6)**: Check the installation with `h5cc -showconfig`.
- **ESMF (v8.8.1)**: Run `ESMF_Info` to display the specific build configuration, including the MPI version and compiler used.
- **ParallelIO (v2.6.6)**: Ensure your model's build system points to this version for optimized parallel I/O.

## Performance Benchmarking
The bundle includes **OSU Micro Benchmarks (v7.5.1)**. Use these to validate that the MVAPICH/UCX stack is performing optimally on your hardware:

- **Point-to-Point**: Run `osu_latency` and `osu_bw` to check basic interconnect performance.
- **Collectives**: Run `osu_allreduce` or `osu_barrier` to test the scaling efficiency of the MPI implementation, which is critical for large-scale climate grids.

## Compilation Best Practices
When building climate models (such as CESM, E3SM, or WRF) against this stack:

1. **Linker Flags**: Always use the output of `nc-config --libs` and `nf-config --flibs` in your Makefiles to ensure all dependencies (like HDF5 and PnetCDF) are correctly linked.
2. **MPI Wrappers**: Ensure you are using the `mpicc`, `mpicxx`, and `mpif90` wrappers provided within the Conda environment to maintain consistency with the MVAPICH 4.0 build.
3. **PnetCDF**: For models requiring high-performance parallel netCDF, utilize the bundled PnetCDF (v1.14.1) which is specifically tuned for this MPI stack.

## Reference documentation
- [ESME MVAPICH 4.0 UCX Overview](./references/anaconda_org_channels_bioconda_packages_esme_mvapich_4_0_ucx_overview.md)