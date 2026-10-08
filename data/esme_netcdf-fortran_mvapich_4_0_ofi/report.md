# esme_netcdf-fortran_mvapich_4_0_ofi CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| esme_netcdf-fortran_mvapich_4_0_ofi_nf-config | PASS | Fixed options from the help (added --includedir); --all reports netCDF-Fortran 4.6.2 with mpicc/mpifort. |

## Metadata
- **Skill**: generated

## esme_netcdf-fortran_mvapich_4_0_ofi_nf-config

### Tool Description
NetCDF-Fortran configuration utility to retrieve settings used during compilation and installation.

### Metadata
- **Docker Image**: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
- **Homepage**: http://www.unidata.ucar.edu/software/netcdf/
- **Package**: https://anaconda.org/channels/bioconda/packages/esme_netcdf-fortran_mvapich_4_0_ofi/overview
- **Validation**: PASS
### Original Help Text
```text
Usage: nf-config [OPTION]

Available values for OPTION include:

  --help        display this help message and exit
  --all         display all options
  --cc          C compiler
  --fc          Fortran compiler
  --cflags      pre-processor and compiler flags
  --fflags      flags needed to compile a Fortran program
  --has-dap     whether OPeNDAP is enabled in this build
  --has-nc2     whether NetCDF-2 API is enabled
  --has-nc4     whether NetCDF-4/HDF-5 is enabled in this build
  --has-f90     whether Fortran 90 API is enabled in this build
  --has-f03     whether Fortran 2003 API is enabled in this build
  --flibs       libraries needed to link a Fortran program
  --prefix      Install prefix
  --includedir  Include directory
  --version     Library version
```

