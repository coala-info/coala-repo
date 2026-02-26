# cdo CWL Generation Report

## cdo

### Tool Description
CDO version 2.0.0, Copyright (C) 2003-2021 MPI für Meteorologie
  This is free software and comes with ABSOLUTELY NO WARRANTY
  Report bugs to <https://mpimet.mpg.de/cdo>

### Metadata
- **Docker Image**: quay.io/biocontainers/cdo:2.0.0
- **Homepage**: https://github.com/cxong/cdogs-sdl
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/conda-forge/packages/cdo/overview
- **Total Downloads**: 602.4K
- **Last updated**: 2025-09-16
- **GitHub**: https://github.com/cxong/cdogs-sdl
- **Stars**: N/A
### Original Help Text
```text
No operator given!

usage : cdo  [Options]  Operator1  [-Operator2  [-OperatorN]]

  Options:
    -a             Generate an absolute time axis
    -A             Dry run that shows processed cdo call
    --attribs      Lists all operators with choosen features or the attributes of given operator(s)
                   operator name or a combination of [arbitrary/filesOnly/onlyFirst/noOutput/obase]
    -b <nbits>     Set the number of bits for the output precision
                   (I8/I16/I32/F32/F64 for nc1/nc2/nc4/nc4c/nc5; U8/U16/U32 for nc4/nc4c/nc5; F32/F64 for grb2/srv/ext/ieg; P1 - P24 for grb1/grb2)
                   Add L or B to set the byteorder to Little or Big endian
    --cmor         CMOR conform NetCDF output
    -C, --color    Set behaviour of colorized output messages <auto,no,all>
    --double       Using double precision floats for data in memory.
    --eccodes      Use ecCodes to decode/encode GRIB1 messages
    --enableexcept <except>
                   Set individual floating-point traps (DIVBYZERO, INEXACT, INVALID, OVERFLOW, UNDERFLOW, ALL_EXCEPT)
    -f, --format <format>
                   Format of the output file. (grb1/grb2/nc1/nc2/nc4/nc4c/nc5/srv/ext/ieg)
    -g <grid>      Set default grid name or file. Available grids: 
                   F<XXX>, t<RES>, tl<RES>, global_<DXY>, r<NX>x<NY>, g<NX>x<NY>, gme<NI>, lon=<LON>/lat=<LAT>
    -h, --help     Help information for the operators
    --ignore_time_bounds  Ignores time bounds for time range statistics
    --no_history   Do not append to NetCDF "history" global attribute
    --netcdf_hdr_pad, --hdr_pad, --header_pad <nbr>
                   Pad NetCDF output header with nbr bytes
    -k <chunktype> NetCDF4 chunk type: auto, grid or lines
    -L             Lock IO (sequential access)
    -m <missval>   Set the missing value of non NetCDF files (default: -9e+33)
    -O             Overwrite existing output file, if checked
    --operators    List of all operators
    --pedantic     Warnings count as errors
    -P <nthreads>  Set number of OpenMP threads
    --percentile <method>
                   Percentile method: nrank, nist, rtype8, numpy, numpy_lower, numpy_higher, numpy_nearest
    --precision <float_digits[,double_digits]>
                   Precision to use in displaying floating-point data (default: 7,15)
    --reduce_dim   Reduce NetCDF dimensions
    --no_remap_weights Switch off generation of remap weights
    -R, --regular  Convert GRIB1 data from global reduced to regular Gaussian grid (cgribex only)
    -r             Generate a relative time axis
    -S             Create an extra output stream for the module TIMSTAT. This stream
                   contains the number of non missing values for each output period.
    -s, --silent   Silent mode
    --seed <seed>  Seed for a new sequence of pseudo-random numbers.
    --single       Using single precision floats for data in memory.
    --sortname     Alphanumeric sorting of NetCDF parameter names
    -t <codetab>   Set GRIB1 default parameter code table name or file (cgribex only)
                   Predefined tables:  echam4 echam5 echam6 mpiom1 ecmwf remo cosmo002 cosmo201 cosmo202 cosmo203 cosmo205 cosmo250
    --timestat_date <srcdate>
                   Target timestamp (temporal statistics): first, middle, midhigh or last source timestep.
    -V, --version  Print the version number
    -v, --verbose  Print extra details for some operators
    -w             Disable warning messages
    --worker <num> Number of worker to decode/decompress GRIB records
    -z szip        SZIP compression of GRIB1 records
       aec         AEC compression of GRIB2 records
       jpeg        JPEG compression of GRIB2 records
        zip[_1-9]  Deflate compression of NetCDF4 variables

  Operators:
    Use option --operators for a list of all operators.

  CDO version 2.0.0, Copyright (C) 2003-2021 MPI für Meteorologie
  This is free software and comes with ABSOLUTELY NO WARRANTY
  Report bugs to <https://mpimet.mpg.de/cdo>
```


## Metadata
- **Skill**: generated
