cwlVersion: v1.2
class: CommandLineTool
baseCommand: cdo
label: cdo
doc: "Climate Data Operators (CDO): apply one or a chain of operators to climate and
  NWP model data (NetCDF, GRIB, SERVICE, EXTRA, IEG). Usage: cdo [Options] Operator1
  [-Operator2 [-OperatorN]] infiles outfile\n\nTool homepage: https://code.mpimet.mpg.de/projects/cdo"
inputs:
  - id: operator
    type: string
    doc: Operator to apply, with its parameters (e.g. fldmean, selname,tas)
    inputBinding:
      position: 2
  - id: additional_operators
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional chained operators, each with a leading dash (e.g. 
      -selname,tas)
    inputBinding:
      position: 3
  - id: cmor_conform_netcdf_output
    type:
      - 'null'
      - boolean
    doc: CMOR conform NetCDF output
    inputBinding:
      position: 1
      prefix: --cmor
  - id: colorized_output
    type:
      - 'null'
      - string
    doc: Set behaviour of colorized output messages <auto,no,all>
    inputBinding:
      position: 1
      prefix: --color
  - id: convert_grib1_to_regular_gaussian
    type:
      - 'null'
      - boolean
    doc: Convert GRIB1 data from global reduced to regular Gaussian grid 
      (cgribex only)
    inputBinding:
      position: 1
      prefix: --regular
  - id: create_timstat_stream
    type:
      - 'null'
      - boolean
    doc: "Create an extra output stream for the module TIMSTAT. This stream\n    \
      \               contains the number of non missing values for each output period."
    inputBinding:
      position: 1
      prefix: -S
  - id: default_grid
    type:
      - 'null'
      - string
    doc: "Set default grid name or file. Available grids: \n                   F<XXX>,
      t<RES>, tl<RES>, global_<DXY>, r<NX>x<NY>, g<NX>x<NY>, gme<NI>, lon=<LON>/lat=<LAT>"
    inputBinding:
      position: 1
      prefix: -g
  - id: disable_remap_weights
    type:
      - 'null'
      - boolean
    doc: Switch off generation of remap weights
    inputBinding:
      position: 1
      prefix: --no_remap_weights
  - id: disable_warning_messages
    type:
      - 'null'
      - boolean
    doc: Disable warning messages
    inputBinding:
      position: 1
      prefix: -w
  - id: display_precision
    type:
      - 'null'
      - string
    doc: 'Precision to use in displaying floating-point data (default: 7,15)'
    inputBinding:
      position: 1
      prefix: --precision
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Dry run that shows processed cdo call
    inputBinding:
      position: 1
      prefix: -A
  - id: enable_floating_point_exceptions
    type:
      - 'null'
      - string
    doc: Set individual floating-point traps (DIVBYZERO, INEXACT, INVALID, 
      OVERFLOW, UNDERFLOW, ALL_EXCEPT)
    inputBinding:
      position: 1
      prefix: --enableexcept
  - id: generate_absolute_time_axis
    type:
      - 'null'
      - boolean
    doc: Generate an absolute time axis
    inputBinding:
      position: 1
      prefix: -a
  - id: generate_relative_time_axis
    type:
      - 'null'
      - boolean
    doc: Generate a relative time axis
    inputBinding:
      position: 1
      prefix: -r
  - id: grib1_codetable
    type:
      - 'null'
      - string
    doc: "Set GRIB1 default parameter code table name or file (cgribex only)\n   \
      \                Predefined tables:  echam4 echam5 echam6 mpiom1 ecmwf remo
      cosmo002 cosmo201 cosmo202 cosmo203 cosmo205 cosmo250"
    inputBinding:
      position: 1
      prefix: -t
  - id: header_pad
    type:
      - 'null'
      - int
    doc: Pad NetCDF output header with nbr bytes
    inputBinding:
      position: 1
      prefix: --hdr_pad
  - id: ignore_time_bounds
    type:
      - 'null'
      - boolean
    doc: Ignores time bounds for time range statistics
    inputBinding:
      position: 1
      prefix: --ignore_time_bounds
  - id: list_all_operators
    type:
      - 'null'
      - boolean
    doc: List of all operators
    inputBinding:
      position: 1
      prefix: --operators
  - id: list_operators_with_features
    type:
      - 'null'
      - string
    doc: "Lists all operators with choosen features or the attributes of given operator(s)\n\
      \                   operator name or a combination of [arbitrary/filesOnly/onlyFirst/noOutput/obase]"
    inputBinding:
      position: 1
      prefix: --attribs
  - id: lock_io
    type:
      - 'null'
      - boolean
    doc: Lock IO (sequential access)
    inputBinding:
      position: 1
      prefix: -L
  - id: missing_value
    type:
      - 'null'
      - float
    doc: 'Set the missing value of non NetCDF files (default: -9e+33)'
    inputBinding:
      position: 1
      prefix: -m
  - id: netcdf4_chunk_type
    type:
      - 'null'
      - string
    doc: 'NetCDF4 chunk type: auto, grid or lines'
    inputBinding:
      position: 1
      prefix: -k
  - id: netcdf_header_padding
    type:
      - 'null'
      - int
    doc: Pad NetCDF output header with nbr bytes
    inputBinding:
      position: 1
      prefix: --netcdf_hdr_pad
  - id: no_history_attribute
    type:
      - 'null'
      - boolean
    doc: Do not append to NetCDF "history" global attribute
    inputBinding:
      position: 1
      prefix: --no_history
  - id: num_openmp_threads
    type:
      - 'null'
      - int
    doc: Set number of OpenMP threads
    inputBinding:
      position: 1
      prefix: -P
  - id: num_workers_grib
    type:
      - 'null'
      - int
    doc: Number of worker to decode/decompress GRIB records
    inputBinding:
      position: 1
      prefix: --worker
  - id: output_format
    type:
      - 'null'
      - string
    doc: Format of the output file. (grb1/grb2/nc1/nc2/nc4/nc4c/nc5/srv/ext/ieg)
    inputBinding:
      position: 1
      prefix: --format
  - id: output_precision_bits
    type:
      - 'null'
      - string
    doc: "Set the number of bits for the output precision\n                   (I8/I16/I32/F32/F64
      for nc1/nc2/nc4/nc4c/nc5; U8/U16/U32 for nc4/nc4c/nc5; F32/F64 for grb2/srv/ext/ieg;
      P1 - P24 for grb1/grb2)\n                   Add L or B to set the byteorder
      to Little or Big endian"
    inputBinding:
      position: 1
      prefix: -b
  - id: overwrite_output
    type:
      - 'null'
      - boolean
    doc: Overwrite existing output file, if checked
    inputBinding:
      position: 1
      prefix: -O
  - id: pedantic_warnings
    type:
      - 'null'
      - boolean
    doc: Warnings count as errors
    inputBinding:
      position: 1
      prefix: --pedantic
  - id: percentile_method
    type:
      - 'null'
      - string
    doc: 'Percentile method: nrank, nist, rtype8, numpy, numpy_lower, numpy_higher,
      numpy_nearest'
    inputBinding:
      position: 1
      prefix: --percentile
  - id: random_seed
    type:
      - 'null'
      - string
    doc: Seed for a new sequence of pseudo-random numbers.
    inputBinding:
      position: 1
      prefix: --seed
  - id: reduce_dimensions
    type:
      - 'null'
      - boolean
    doc: Reduce NetCDF dimensions
    inputBinding:
      position: 1
      prefix: --reduce_dim
  - id: silent_mode
    type:
      - 'null'
      - boolean
    doc: Silent mode
    inputBinding:
      position: 1
      prefix: --silent
  - id: sort_netcdf_parameter_names
    type:
      - 'null'
      - boolean
    doc: Alphanumeric sorting of NetCDF parameter names
    inputBinding:
      position: 1
      prefix: --sortname
  - id: timestat_date
    type:
      - 'null'
      - string
    doc: 'Target timestamp (temporal statistics): first, middle, midhigh or last source
      timestep.'
    inputBinding:
      position: 1
      prefix: --timestat_date
  - id: use_double_precision
    type:
      - 'null'
      - boolean
    doc: Using double precision floats for data in memory.
    inputBinding:
      position: 1
      prefix: --double
  - id: use_ecCodes
    type:
      - 'null'
      - boolean
    doc: Use ecCodes to decode/encode GRIB1 messages
    inputBinding:
      position: 1
      prefix: --eccodes
  - id: use_single_precision
    type:
      - 'null'
      - boolean
    doc: Using single precision floats for data in memory.
    inputBinding:
      position: 1
      prefix: --single
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print extra details for some operators
    inputBinding:
      position: 1
      prefix: --verbose
  - id: compression
    type:
      - 'null'
      - string
    doc: "Compression: szip (SZIP compression of GRIB1 records), aec (AEC 
      compression of GRIB2 records), jpeg (JPEG compression of GRIB2 records), 
      zip[_1-9] (Deflate compression of NetCDF4 variables)"
    inputBinding:
      position: 1
      prefix: -z
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input data file(s)
    inputBinding:
      position: 4
  - id: output_file
    type:
      - 'null'
      - string
    doc: Output file name (for operators that write a file)
    inputBinding:
      position: 5
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output
    type:
      - 'null'
      - File
    doc: Output file written by the operator
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cdo:2.0.0
stdout: cdo.out
