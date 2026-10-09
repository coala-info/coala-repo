cwlVersion: v1.2
class: CommandLineTool
baseCommand: h5repack
label: hdf5_h5repack
doc: "Repacks HDF5 files\n\nTool homepage: https://github.com/HDFGroup/hdf5"
inputs:
  - id: input_file
    type: File
    doc: Input HDF5 File
    inputBinding:
      position: 201
  - id: alignment
    type:
      - 'null'
      - int
    doc: Alignment value for H5Pset_alignment
    inputBinding:
      position: 102
      prefix: --alignment=
      separate: false
  - id: block_size
    type:
      - 'null'
      - int
    doc: Size of user block to be added
    inputBinding:
      position: 102
      prefix: --block=
      separate: false
  - id: compact
    type:
      - 'null'
      - int
    doc: Maximum number of links in header messages
    inputBinding:
      position: 102
      prefix: --compact=
      separate: false
  - id: enable_error_stack
    type:
      - 'null'
      - boolean
    doc: Prints messages from the HDF5 error stack as they occur
    inputBinding:
      position: 102
      prefix: --enable-error-stack
  - id: filter
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --filter=
          separate: false
    doc: Filter type, for example GZIP=1 or SHUF. Repeat to add several filters.
    inputBinding:
      position: 102
  - id: filter_file
    type:
      - 'null'
      - File
    doc: Name of file E with the -f and -l options
    inputBinding:
      position: 102
      prefix: --file=
      separate: false
  - id: fs_pagesize
    type:
      - 'null'
      - int
    doc: File space page size for H5Pset_file_space_page_size
    inputBinding:
      position: 102
      prefix: --fs_pagesize=
      separate: false
  - id: fs_persist
    type:
      - 'null'
      - int
    doc: Persisting or not persisting free-space for H5Pset_file_space_strategy
    inputBinding:
      position: 102
      prefix: --fs_persist=
      separate: false
  - id: fs_strategy
    type:
      - 'null'
      - string
    doc: File space management strategy for H5Pset_file_space_strategy
    inputBinding:
      position: 102
      prefix: --fs_strategy=
      separate: false
  - id: fs_threshold
    type:
      - 'null'
      - int
    doc: Free-space section threshold for H5Pset_file_space_strategy
    inputBinding:
      position: 102
      prefix: --fs_threshold=
      separate: false
  - id: high_bound
    type:
      - 'null'
      - int
    doc: The high bound for library release versions to use when creating 
      objects in the file
    inputBinding:
      position: 102
      prefix: --high=
      separate: false
  - id: indexed
    type:
      - 'null'
      - int
    doc: Minimum number of links in the indexed format
    inputBinding:
      position: 102
      prefix: --indexed=
      separate: false
  - id: latest
    type:
      - 'null'
      - boolean
    doc: Use latest version of file format. This option will take precedence 
      over the -j and -k options
    inputBinding:
      position: 102
      prefix: --latest
  - id: layout
    type:
      - 'null'
      - string
    doc: Layout type
    inputBinding:
      position: 102
      prefix: --layout=
      separate: false
  - id: low_bound
    type:
      - 'null'
      - int
    doc: The low bound for library release versions to use when creating objects
      in the file
    inputBinding:
      position: 102
      prefix: --low=
      separate: false
  - id: metadata_block_size
    type:
      - 'null'
      - int
    doc: Metadata block size for H5Pset_meta_block_size
    inputBinding:
      position: 102
      prefix: --metadata_block_size=
      separate: false
  - id: minimum_dataset_size
    type:
      - 'null'
      - int
    doc: Do not apply the filter to datasets smaller than M
    inputBinding:
      position: 102
      prefix: --minimum=
      separate: false
  - id: native
    type:
      - 'null'
      - boolean
    doc: Use a native HDF5 type when repacking
    inputBinding:
      position: 102
      prefix: --native
  - id: sort_by
    type:
      - 'null'
      - string
    doc: Sort groups and attributes by index Q
    inputBinding:
      position: 102
      prefix: --sort_by=
      separate: false
  - id: sort_order
    type:
      - 'null'
      - string
    doc: Sort groups and attributes by order Z
    inputBinding:
      position: 102
      prefix: --sort_order=
      separate: false
  - id: ssize
    type:
      - 'null'
      - string
    doc: Shared object header message minimum size
    inputBinding:
      position: 102
      prefix: --ssize=
      separate: false
  - id: threshold
    type:
      - 'null'
      - int
    doc: Threshold value for H5Pset_alignment
    inputBinding:
      position: 102
      prefix: --threshold=
      separate: false
  - id: ublock_file
    type:
      - 'null'
      - File
    doc: Name of file U with user block data to be added
    inputBinding:
      position: 102
      prefix: --ublock=
      separate: false
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode, print object information
    inputBinding:
      position: 102
      prefix: --verbose
  - id: output_file_path
    type: string
    doc: Output HDF5 file name
    inputBinding:
      position: 202
outputs:
  - id: output_file
    type: File
    doc: Output HDF5 File
    outputBinding:
      glob: $(inputs.output_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hdf5:1.10.4
