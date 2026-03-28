# esme_pnetcdf_openmpi_5_0_6 CWL Generation Report

## esme_pnetcdf_openmpi_5_0_6_ncvalidator

### Tool Description
Validate netCDF files

### Metadata
- **Docker Image**: quay.io/biocontainers/esme_pnetcdf_openmpi_5_0_6:1.14.0--h1080dc9_0
- **Homepage**: https://parallel-netcdf.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/esme_pnetcdf_openmpi_5_0_6/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/esme_pnetcdf_openmpi_5_0_6/overview
- **Total Downloads**: 187
- **Last updated**: 2025-04-22
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
*PnetCDF library version 1.14.0 of November 11, 2024
```


## esme_pnetcdf_openmpi_5_0_6_ncmpidiff

### Tool Description
Compare the contents of two netCDF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/esme_pnetcdf_openmpi_5_0_6:1.14.0--h1080dc9_0
- **Homepage**: https://parallel-netcdf.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/esme_pnetcdf_openmpi_5_0_6/overview
- **Validation**: PASS

### Original Help Text
```text
ncmpidiff [-b] [-q] [-h] [-v ...] [-t diff,ratio] file1 file2
  Compare the contents of two netCDF files.
  [-b]             Verbose output
  [-q]             quiet mode (no output if two files are the same)
  [-h]             Compare header information only, no variables
  [-v var1[,...]]  Compare variable(s) <var1>,... only
  [-t diff,ratio]  Tolerance: diff is absolute element-wise difference
                   and ratio is relative element-wise difference defined
                   as |x - y|/max(|x|, |y|)
  file1 file2      File names of two input netCDF files to be compared
*PnetCDF library version 1.14.0 of November 11, 2024
```


## esme_pnetcdf_openmpi_5_0_6_ncoffsets

### Tool Description
Prints offsets of variables in a netCDF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/esme_pnetcdf_openmpi_5_0_6:1.14.0--h1080dc9_0
- **Homepage**: https://parallel-netcdf.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/esme_pnetcdf_openmpi_5_0_6/overview
- **Validation**: PASS

### Original Help Text
```text
ncoffsets: missing file name
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
*PnetCDF library version 1.14.0 of November 11, 2024
```


## esme_pnetcdf_openmpi_5_0_6_pnetcdf-config

### Tool Description
is a utility program to display the build and installation information of the PnetCDF library.

### Metadata
- **Docker Image**: quay.io/biocontainers/esme_pnetcdf_openmpi_5_0_6:1.14.0--h1080dc9_0
- **Homepage**: https://parallel-netcdf.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/esme_pnetcdf_openmpi_5_0_6/overview
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


## esme_pnetcdf_openmpi_5_0_6_pnetcdf_version

### Tool Description
PnetCDF Version Information

### Metadata
- **Docker Image**: quay.io/biocontainers/esme_pnetcdf_openmpi_5_0_6:1.14.0--h1080dc9_0
- **Homepage**: https://parallel-netcdf.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/esme_pnetcdf_openmpi_5_0_6/overview
- **Validation**: PASS

### Original Help Text
```text
PnetCDF Version:    	1.14.0
PnetCDF Release date:	November 11, 2024
PnetCDF configure: 	--prefix=/usr/local --with-mpi=/usr/local --enable-shared=yes --enable-static=no --disable-dependency-tracking --enable-thread-safe
MPICC:  /usr/local/bin/mpicc -march=nocona -mtune=haswell -ftree-vectorize -fPIC -fstack-protector-strong -fno-plt -O2 -ffunction-sections -pipe -isystem /usr/local/include -fdebug-prefix-map=/opt/conda/conda-bld/esme_openmpi_5_0_6_1740127261407/work=/usr/local/src/conda/esme_pnetcdf_openmpi_5_0_6-1.14.0 -fdebug-prefix-map=/usr/local=/usr/local/src/conda-prefix
MPICXX: /usr/local/bin/mpicxx -fvisibility-inlines-hidden -fmessage-length=0 -march=nocona -mtune=haswell -ftree-vectorize -fPIC -fstack-protector-strong -fno-plt -O2 -ffunction-sections -pipe -isystem /usr/local/include -fdebug-prefix-map=/opt/conda/conda-bld/esme_openmpi_5_0_6_1740127261407/work=/usr/local/src/conda/esme_pnetcdf_openmpi_5_0_6-1.14.0 -fdebug-prefix-map=/usr/local=/usr/local/src/conda-prefix
MPIF77: /usr/local/bin/mpif77 -march=nocona -mtune=haswell -ftree-vectorize -fPIC -fstack-protector-strong -fno-plt -O2 -ffunction-sections -pipe -isystem /usr/local/include -I/opt/conda/conda-bld/esme_openmpi_5_0_6_1740127261407/_build_env/include -fdebug-prefix-map=/opt/conda/conda-bld/esme_openmpi_5_0_6_1740127261407/work=/usr/local/src/conda/esme_pnetcdf_openmpi_5_0_6-1.14.0 -fdebug-prefix-map=/usr/local=/usr/local/src/conda-prefix -fallow-argument-mismatch
MPIF90: /usr/local/bin/mpif90 -g -O2 -fallow-argument-mismatch
```


## Metadata
- **Skill**: generated
