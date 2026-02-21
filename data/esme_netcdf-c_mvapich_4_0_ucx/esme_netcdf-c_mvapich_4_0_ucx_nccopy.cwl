cwlVersion: v1.2
class: CommandLineTool
baseCommand: nccopy
label: esme_netcdf-c_mvapich_4_0_ucx_nccopy
doc: "Copy a netCDF file, optionally changing format, compression, or chunking in
  the process.\n\nTool homepage: http://www.unidata.ucar.edu/software/netcdf/"
inputs:
  - id: input_file
    type: File
    doc: The input netCDF file to be copied.
    inputBinding:
      position: 1
  - id: buffer_size
    type:
      - 'null'
      - string
    doc: Specifies the size in bytes of the copy buffer used.
    inputBinding:
      position: 102
      prefix: -m
  - id: chunkspec
    type:
      - 'null'
      - string
    doc: Specifies chunking for dimensions in the output (e.g., 'dim1/n1,dim2/n2,...').
    inputBinding:
      position: 102
      prefix: -c
  - id: deflation_level
    type:
      - 'null'
      - int
    doc: Specifies the deflation level (compression) for the output, from 0 (none)
      to 9 (max).
    inputBinding:
      position: 102
      prefix: -d
  - id: header_pad
    type:
      - 'null'
      - int
    doc: Specifies the chunk cache size in bytes.
    inputBinding:
      position: 102
      prefix: -h
  - id: kind
    type:
      - 'null'
      - string
    doc: Specifies the kind of netCDF format for the output (e.g., 'classic', '64-bit-offset',
      'netCDF-4', 'netCDF-4-classic').
    inputBinding:
      position: 102
      prefix: -k
  - id: min_chunk_size
    type:
      - 'null'
      - int
    doc: Specifies the minimum size of a chunk.
    inputBinding:
      position: 102
      prefix: -min_chunk_size
  - id: shuffle
    type:
      - 'null'
      - boolean
    doc: Specifies shuffling of variable data before compression, which may improve
      compression ratio.
    inputBinding:
      position: 102
      prefix: -s
outputs:
  - id: output_file
    type: File
    doc: The name of the output netCDF file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/esme_netcdf-fortran_mvapich_4_0_ofi:4.6.2--hb2a3317_0
