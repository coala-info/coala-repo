# esme_netcdf-c_mvapich_4_0_ucx CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| esme_netcdf-c_mvapich_4_0_ucx_nccopy | Failed | image problem: nccopy (and ncdump, ncgen) in the package's own image cannot load libpnetcdf.so.7/libhdf5.so.310; the rewritten CWL works on real netcdf-c test data with the same nccopy 4.9.3 from esme_mvapich_4_0_ucx. |

## Metadata
- **Skill**: generated

## esme_netcdf-c_mvapich_4_0_ucx_nccopy

### Tool Description
Copy a netCDF file, optionally changing format, compression, or chunking in the process.

### Metadata
- **Docker Image**: quay.io/biocontainers/esme_netcdf-c_mvapich_4_0_ucx:4.9.3--hdf4d085_0
- **Homepage**: http://www.unidata.ucar.edu/software/netcdf/
- **Package**: https://anaconda.org/channels/bioconda/packages/esme_netcdf-c_mvapich_4_0_ucx/overview
- **Validation**: PASS
### Original Help Text
```text
nccopy: nccopy [-k kind] [-[3|4|6|7]] [-d n] [-s] [-c chunkspec] [-u] [-w] [-[v|V] varlist] [-[g|G] grplist] [-m n] [-h n] [-e n] [-r] [-F filterspec] [-Ln] [-Mn] infile outfile
  [-k kind] specify kind of netCDF format for output file, default same as input
	    kind strings: 'classic', '64-bit offset', 'cdf5',
                          'netCDF-4', 'netCDF-4 classic model'
  [-3]      netCDF classic output (same as -k 'classic')
  [-6]      64-bit-offset output (same as -k '64-bit offset')
  [-4]      netCDF-4 output (same as -k 'netCDF-4')
  [-7]      netCDF-4-classic output (same as -k 'netCDF-4 classic model')
  [-5]      CDF5 output (same as -k 'cdf5)
  [-d n]    set output deflation compression level, default same as input (0=none 9=max)
  [-s]      add shuffle option to deflation compression
  [-c chunkspec] specify chunking for variable and dimensions, e.g. "var:N1,N2,..." or "dim1/N1,dim2/N2,..."
  [-u]      convert unlimited dimensions to fixed-size dimensions in output copy
  [-w]      write whole output file from diskless netCDF on close
  [-v var1,...] include data for only listed variables, but definitions for all variables
  [-V var1,...] include definitions and data for only listed variables
  [-g grp1,...] include data for only variables in listed groups, but all definitions
  [-G grp1,...] include definitions and data only for variables in listed groups
  [-m n]    set size in bytes of copy buffer, default is 5000000 bytes
  [-h n]    set size in bytes of chunk_cache for chunked variables
  [-e n]    set number of elements that chunk_cache can hold
  [-r]      read whole input file into diskless file on open (classic or 64-bit offset or cdf5 formats only)
  [-F filterspec] specify a compression algorithm to apply to an output variable (may be repeated).
  [-Ln]     set log level to n (>= 0); ignored if logging isn't enabled.
  [-Mn]     set minimum chunk size to n bytes (n >= 0)
  infile    name of netCDF input file
  outfile   name for netCDF output file

netCDF library version 4.9.3 of Aug  6 2025 08:44:36 $
```

