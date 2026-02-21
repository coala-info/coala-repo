---
name: esme_netcdf-c_openmpi_5_0_6
description: This skill provides guidance for utilizing the `esme_netcdf-c_openmpi_5_0_6` package, which provides the C interface for the Network Common Data Form (netCDF).
homepage: http://www.unidata.ucar.edu/software/netcdf/
---

# esme_netcdf-c_openmpi_5_0_6

## Overview

This skill provides guidance for utilizing the `esme_netcdf-c_openmpi_5_0_6` package, which provides the C interface for the Network Common Data Form (netCDF). This specific build is optimized for high-performance computing environments using OpenMPI 5.0.6, enabling parallel data access and manipulation. It is primarily used by researchers and developers to handle large-scale multidimensional arrays common in atmospheric, oceanic, and earth sciences.

## Usage Patterns and Best Practices

### Environment Setup
To use this tool, ensure the bioconda channel is configured and the environment is active:
```bash
conda install bioconda::esme_netcdf-c_openmpi_5_0_6
```

### Common CLI Utilities
The package includes several standard netCDF utilities that are essential for inspecting and manipulating files:

- **ncdump**: Converts netCDF files to ASCII (CDL) format.
  - *View header only*: `ncdump -h filename.nc`
  - *View data for specific variable*: `ncdump -v variable_name filename.nc`
  - *Coordinate values*: `ncdump -c filename.nc`
- **ncgen**: Generates a netCDF file from a CDL (text) description.
  - *Create binary from CDL*: `ncgen -o output.nc input.cdl`
  - *Generate C code to create the file*: `ncgen -lc input.cdl > create_file.c`
- **nccopy**: Copies and optionally compresses or re-chunks netCDF files.
  - *Convert to netCDF-4*: `nccopy -k netCDF-4 input.nc output.nc`
  - *Apply compression*: `nccopy -d 5 input.nc output.nc` (Deflate level 5)

### Parallel I/O Considerations
Since this build is linked against OpenMPI 5.0.6, it supports parallel I/O. When writing C code to interface with this library:
- Use `nc_create_par` or `nc_open_par` instead of the standard `nc_create`/`nc_open`.
- Ensure you pass the `MPI_Comm` and `MPI_Info` objects to the parallel open/create functions.
- Set the access mode to `NC_COLLECTIVE` for metadata operations and coordinated data writes to maximize performance on parallel filesystems.

### Expert Tips
- **Chunking**: For large datasets, use `nccopy` to experiment with different chunking strategies. Proper chunking is critical for performance when accessing subsets of data over MPI.
- **Format Selection**: While netCDF-3 (classic) is portable, use netCDF-4 (HDF5-based) for features like compression, multiple unlimited dimensions, and better parallel I/O performance.
- **Environment Variables**: When compiling your own C applications against this library, ensure `OMPI_CC` is set to your preferred compiler if using `mpicc` wrappers.

## Reference documentation
- [NetCDF-C - netCDF interface for C](./references/anaconda_org_channels_bioconda_packages_esme_netcdf-c_openmpi_5_0_6_overview.md)
- [NetCDF Software Documentation](./references/www_unidata_ucar_edu_software_netcdf.md)