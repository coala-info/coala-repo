# esme_pnetcdf_mvapich_4_0_ucx CWL Generation Report

## esme_pnetcdf_mvapich_4_0_ucx_ncvalidator

### Tool Description
Validate netCDF files

### Metadata
- **Docker Image**: quay.io/biocontainers/esme_pnetcdf_mvapich_4_0_ucx:1.14.1--hf580d27_0
- **Homepage**: https://parallel-netcdf.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/esme_pnetcdf_mvapich_4_0_ucx/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/esme_pnetcdf_mvapich_4_0_ucx/overview
- **Total Downloads**: 290
- **Last updated**: 2025-08-13
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: ncvalidator [-h] | [-t] [-x] [-q] file
       [-h] Print help
       [-t] Turn on tracing mode, printing progress of validation
       [-x] Repair in-place the null-byte padding in file header.
       [-q] Quiet mode (exit 1 when fail, 0 success)
       file: Input netCDF file name
*PnetCDF library version 1.14.1 of July 31, 2025
```


## esme_pnetcdf_mvapich_4_0_ucx_ncoffsets

### Tool Description
Output variable offsets, sizes, and gaps in a netCDF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/esme_pnetcdf_mvapich_4_0_ucx:1.14.1--hf580d27_0
- **Homepage**: https://parallel-netcdf.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/esme_pnetcdf_mvapich_4_0_ucx/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ncoffsets [-h] | [-x] | [-sgr] [-v var1[,...]] file
       [-h]            Print help
       [-v var1[,...]] Output for variable(s) <var1>,... only
       [-s]            Output variable size. For record variables, output
                       the size of one record only
       [-g]            Output gap from the previous variable
       [-r]            Output offsets for all records
       [-x]            Check gaps in fixed-size variables, output 1 if gaps
                       are found, 0 for otherwise.
       file            Input netCDF file name
*PnetCDF library version 1.14.1 of July 31, 2025
```


## esme_pnetcdf_mvapich_4_0_ucx_pnetcdf-config

### Tool Description
pnetcdf-config is a utility program to display the build and installation information of the PnetCDF library.

### Metadata
- **Docker Image**: quay.io/biocontainers/esme_pnetcdf_mvapich_4_0_ucx:1.14.1--hf580d27_0
- **Homepage**: https://parallel-netcdf.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/esme_pnetcdf_mvapich_4_0_ucx/overview
- **Validation**: PASS

### Original Help Text
```text
pnetcdf-config is a utility program to display the build and installation
information of the PnetCDF library.

Usage: pnetcdf-config [OPTION]

Available values for OPTION include:

  --help                      display this help message and exit
  --all                       display all options
  --cc                        C compiler used to build PnetCDF
  --cflags                    C compiler flags used to build PnetCDF
  --cppflags                  C pre-processor flags used to build PnetCDF
  --has-c++                   whether C++ API is installed
  --c++                       C++ compiler used to build PnetCDF
  --cxxflags                  C++ compiler flags used to build PnetCDF
  --has-fortran               whether Fortran API is installed
  --f77                       Fortran 77 compiler used to build PnetCDF
  --fflags                    Fortran 77 compiler flags used to build PnetCDF
  --fppflags                  Fortran pre-processor flags used to build PnetCDF
  --fc                        Fortran 9x compiler used to build PnetCDF
  --fcflags                   Fortran 9x compiler flags used to build PnetCDF
  --ldflags                   Linker flags used to build PnetCDF
  --libs                      Extra libraries used to build PnetCDF
  --netcdf4                   Whether NetCDF-4 support is enabled or disabled
  --adios                     Whether ADIOS support is enabled or disabled
  --relax-coord-bound         Whether using a relaxed coordinate boundary check
  --in-place-swap             Whether using buffer in-place Endianness byte swap
  --erange-fill               Whether using fill values for NC_ERANGE error
  --subfiling                 Whether subfiling is enabled or disabled
  --null-byte-header-padding  Whether to check null-byte padding in header
  --burst-buffering           Whether burst buffer driver is built or not
  --profiling                 Whether internal profiling is enabled or not
  --thread-safe               Whether thread-safe capability is enabled or not
  --debug                     Whether PnetCDF is built with debug mode
  --prefix                    Installation directory
  --includedir                Installation directory containing header files
  --libdir                    Installation directory containing library files
  --version                   Library version
  --release-date              Date of PnetCDF source was released
  --config-date               Date of PnetCDF library was configured
```


## esme_pnetcdf_mvapich_4_0_ucx_pnetcdf_version

### Tool Description
PnetCDF Version and Release Information

### Metadata
- **Docker Image**: quay.io/biocontainers/esme_pnetcdf_mvapich_4_0_ucx:1.14.1--hf580d27_0
- **Homepage**: https://parallel-netcdf.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/esme_pnetcdf_mvapich_4_0_ucx/overview
- **Validation**: PASS

### Original Help Text
```text
PnetCDF Version:    	1.14.1
PnetCDF Release date:	July 31, 2025
PnetCDF configure: 	--prefix=/usr/local --with-mpi=/usr/local --enable-shared=yes --enable-static=no --disable-dependency-tracking
MPICC:  /usr/local/bin/mpicc -march=nocona -mtune=haswell -ftree-vectorize -fPIC -fstack-protector-strong -fno-plt -O2 -ffunction-sections -pipe -isystem /usr/local/include -fdebug-prefix-map=/opt/conda/conda-bld/esme_mvapich_4_0_ucx_1754469093573/work=/usr/local/src/conda/esme_pnetcdf_mvapich_4_0_ucx-1.14.1 -fdebug-prefix-map=/usr/local=/usr/local/src/conda-prefix
MPICXX: /usr/local/bin/mpicxx -fvisibility-inlines-hidden -fmessage-length=0 -march=nocona -mtune=haswell -ftree-vectorize -fPIC -fstack-protector-strong -fno-plt -O2 -ffunction-sections -pipe -isystem /usr/local/include -fdebug-prefix-map=/opt/conda/conda-bld/esme_mvapich_4_0_ucx_1754469093573/work=/usr/local/src/conda/esme_pnetcdf_mvapich_4_0_ucx-1.14.1 -fdebug-prefix-map=/usr/local=/usr/local/src/conda-prefix
MPIF77: /usr/local/bin/mpif77 -march=nocona -mtune=haswell -ftree-vectorize -fPIC -fstack-protector-strong -fno-plt -O2 -ffunction-sections -pipe -isystem /usr/local/include -I/opt/conda/conda-bld/esme_mvapich_4_0_ucx_1754469093573/_build_env/include -fdebug-prefix-map=/opt/conda/conda-bld/esme_mvapich_4_0_ucx_1754469093573/work=/usr/local/src/conda/esme_pnetcdf_mvapich_4_0_ucx-1.14.1 -fdebug-prefix-map=/usr/local=/usr/local/src/conda-prefix -fallow-argument-mismatch
MPIF90: /usr/local/bin/mpif90 -g -O2 -fallow-argument-mismatch
```

