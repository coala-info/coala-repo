cwlVersion: v1.2
class: CommandLineTool
baseCommand: nccopy
label: esme_netcdf-c_mvapich_4_0_ucx_nccopy
doc: "Copy a netCDF file, optionally changing format, compression, or chunking in
  the process.\n\nTool homepage: http://www.unidata.ucar.edu/software/netcdf/"
inputs:
  - id: input_file
    type: File
    doc: name of netCDF input file
    inputBinding:
      position: 1
  - id: output_file
    type: string
    doc: name for netCDF output file
    inputBinding:
      position: 2
  - id: kind
    type:
      - 'null'
      - string
    doc: "specify kind of netCDF format for output file, default same as input: 'classic',
      '64-bit offset', 'cdf5', 'netCDF-4', 'netCDF-4 classic model'"
    inputBinding:
      position: 0
      prefix: -k
  - id: classic
    type:
      - 'null'
      - boolean
    doc: netCDF classic output (same as -k 'classic')
    inputBinding:
      position: 0
      prefix: '-3'
  - id: offset64
    type:
      - 'null'
      - boolean
    doc: 64-bit-offset output (same as -k '64-bit offset')
    inputBinding:
      position: 0
      prefix: '-6'
  - id: netcdf4
    type:
      - 'null'
      - boolean
    doc: netCDF-4 output (same as -k 'netCDF-4')
    inputBinding:
      position: 0
      prefix: '-4'
  - id: netcdf4_classic
    type:
      - 'null'
      - boolean
    doc: netCDF-4-classic output (same as -k 'netCDF-4 classic model')
    inputBinding:
      position: 0
      prefix: '-7'
  - id: cdf5
    type:
      - 'null'
      - boolean
    doc: CDF5 output (same as -k 'cdf5')
    inputBinding:
      position: 0
      prefix: '-5'
  - id: deflation_level
    type:
      - 'null'
      - int
    doc: set output deflation compression level, default same as input (0=none 9=max)
    inputBinding:
      position: 0
      prefix: -d
  - id: shuffle
    type:
      - 'null'
      - boolean
    doc: add shuffle option to deflation compression
    inputBinding:
      position: 0
      prefix: -s
  - id: chunkspec
    type:
      - 'null'
      - string
    doc: specify chunking for variable and dimensions, e.g. "var:N1,N2,..." or "dim1/N1,dim2/N2,..."
    inputBinding:
      position: 0
      prefix: -c
  - id: fix_unlimited
    type:
      - 'null'
      - boolean
    doc: convert unlimited dimensions to fixed-size dimensions in output copy
    inputBinding:
      position: 0
      prefix: -u
  - id: write_diskless
    type:
      - 'null'
      - boolean
    doc: write whole output file from diskless netCDF on close
    inputBinding:
      position: 0
      prefix: -w
  - id: data_variables
    type:
      - 'null'
      - type: array
        items: string
    doc: include data for only listed variables, but definitions for all variables
    inputBinding:
      position: 0
      prefix: -v
      itemSeparator: ','
  - id: variables
    type:
      - 'null'
      - type: array
        items: string
    doc: include definitions and data for only listed variables
    inputBinding:
      position: 0
      prefix: -V
      itemSeparator: ','
  - id: data_groups
    type:
      - 'null'
      - type: array
        items: string
    doc: include data for only variables in listed groups, but all definitions
    inputBinding:
      position: 0
      prefix: -g
      itemSeparator: ','
  - id: groups
    type:
      - 'null'
      - type: array
        items: string
    doc: include definitions and data only for variables in listed groups
    inputBinding:
      position: 0
      prefix: -G
      itemSeparator: ','
  - id: buffer_size
    type:
      - 'null'
      - long
    doc: set size in bytes of copy buffer, default is 5000000 bytes
    inputBinding:
      position: 0
      prefix: -m
  - id: chunk_cache_size
    type:
      - 'null'
      - long
    doc: set size in bytes of chunk_cache for chunked variables
    inputBinding:
      position: 0
      prefix: -h
  - id: chunk_cache_elements
    type:
      - 'null'
      - long
    doc: set number of elements that chunk_cache can hold
    inputBinding:
      position: 0
      prefix: -e
  - id: read_diskless
    type:
      - 'null'
      - boolean
    doc: read whole input file into diskless file on open (classic or 64-bit offset
      or cdf5 formats only)
    inputBinding:
      position: 0
      prefix: -r
  - id: filterspec
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -F
    doc: specify a compression algorithm to apply to an output variable (may be repeated)
    inputBinding:
      position: 0
  - id: log_level
    type:
      - 'null'
      - int
    doc: set log level to n (>= 0); ignored if logging isn't enabled
    inputBinding:
      position: 0
      prefix: -L
      separate: false
  - id: min_chunk_size
    type:
      - 'null'
      - long
    doc: set minimum chunk size to n bytes (n >= 0)
    inputBinding:
      position: 0
      prefix: -M
      separate: false
outputs:
  - id: output
    type: File
    doc: netCDF output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-c_mvapich_4_0_ucx:4.9.3--hdf4d085_0
