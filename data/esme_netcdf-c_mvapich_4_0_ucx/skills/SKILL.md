---
name: esme_netcdf-c_mvapich_4_0_ucx
description: This tool provides the NetCDF-C interface for managing self-describing scientific data in distributed environments using MVAPICH and UCX. Use when user asks to inspect metadata, generate files from CDL, convert formats, apply compression, or perform parallel I/O operations on large datasets.
homepage: http://www.unidata.ucar.edu/software/netcdf/
metadata:
  docker_image: "quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0"
---

# esme_netcdf-c_mvapich_4_0_ucx

## Overview

This skill facilitates the use of the NetCDF-C interface within distributed computing environments. NetCDF (Network Common Data Form) is the industry standard for sharing self-describing, machine-independent scientific data. Because this version is linked with MVAPICH and UCX, it is specifically intended for workloads that require high-speed interconnects and parallel data access across multiple compute nodes. It allows for efficient handling of large datasets by enabling simultaneous read/write operations from multiple MPI processes.

## Installation and Environment Setup

To provide the necessary environment for this tool, install it via conda:

```bash
conda install bioconda::esme_netcdf-c_mvapich_4_0_ucx
```

Since this build relies on MVAPICH and UCX, ensure your environment's MPI runners are compatible with the MVAPICH 4.0 stack to avoid ABI conflicts.

## Common CLI Patterns

### Inspecting Metadata
Use `ncdump` to view the header information or data content of a NetCDF file. This is essential for verifying dimensions, variables, and attributes.

```bash
# View header information only (metadata)
ncdump -h filename.nc

# View header and coordinate variable data
ncdump -c filename.nc
```

### Generating Files from CDL
Use `ncgen` to create a binary NetCDF file from a text-based Common Data Language (CDL) description.

```bash
# Generate a NetCDF-4 file from a CDL file
ncgen -o output.nc -k netCDF-4 input.cdl
```

### Data Conversion and Compression
Use `nccopy` to convert between NetCDF formats or to apply compression (deflation) to an existing file.

```bash
# Convert to NetCDF-4 with a compression level of 4
nccopy -d 4 input.nc output_compressed.nc
```

## Parallel Execution Best Practices

As an MPI-enabled build, performance is maximized when utilizing parallel I/O.

1.  **Parallel Invocation**: When using custom C programs compiled against this library, always invoke them through the MPI process manager:
    ```bash
    mpirun -np <processes> ./your_netcdf_application
    ```
2.  **UCX Tuning**: In some HPC environments, you may need to specify UCX transports to ensure optimal performance with the underlying hardware (e.g., InfiniBand):
    ```bash
    export UCX_TLS=ib,sm,self
    mpirun -np 16 ./your_netcdf_application
    ```
3.  **File Format Selection**: For parallel writes, ensure you are using the NetCDF-4 format (which uses HDF5) or the PnetCDF-based classic formats, as these support concurrent access.

## Expert Tips

*   **Chunking**: When creating large datasets for parallel access, define "chunks" that align with your typical access patterns to reduce I/O overhead.
*   **Attribute Storage**: Use global attributes to store provenance information (e.g., simulation parameters, timestamps) directly within the file to maintain the "self-describing" nature of the data.
*   **Library Linking**: When compiling C code, use `nc-config --all` to retrieve the correct compiler flags and library paths for this specific MVAPICH/UCX build.

## Reference documentation
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_esme_netcdf-c_mvapich_4_0_ucx_overview.md)
- [NetCDF Software Documentation](./references/www_unidata_ucar_edu_software_netcdf.md)