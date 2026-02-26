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
      position: 1
  - id: alignment
    type:
      - 'null'
      - int
    doc: Alignment value for H5Pset_alignment
    inputBinding:
      position: 102
      prefix: --alignment
  - id: block_size
    type:
      - 'null'
      - int
    doc: Size of user block to be added
    default: 1024
    inputBinding:
      position: 102
      prefix: --block
  - id: compact
    type:
      - 'null'
      - int
    doc: Maximum number of links in header messages
    inputBinding:
      position: 102
      prefix: --compact
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
    doc: Filter type
    inputBinding:
      position: 102
      prefix: --filter
  - id: filter_file
    type:
      - 'null'
      - File
    doc: Name of file E with the -f and -l options
    inputBinding:
      position: 102
      prefix: --file
  - id: fs_pagesize
    type:
      - 'null'
      - int
    doc: File space page size for H5Pset_file_space_page_size
    default: 4096
    inputBinding:
      position: 102
      prefix: --fs_pagesize
  - id: fs_persist
    type:
      - 'null'
      - int
    doc: Persisting or not persisting free-space for H5Pset_file_space_strategy
    inputBinding:
      position: 102
      prefix: --fs_persist
  - id: fs_strategy
    type:
      - 'null'
      - string
    doc: File space management strategy for H5Pset_file_space_strategy
    inputBinding:
      position: 102
      prefix: --fs_strategy
  - id: fs_threshold
    type:
      - 'null'
      - int
    doc: Free-space section threshold for H5Pset_file_space_strategy
    inputBinding:
      position: 102
      prefix: --fs_threshold
  - id: high_bound
    type:
      - 'null'
      - int
    doc: The high bound for library release versions to use when creating 
      objects in the file
    default: H5F_LIBVER_LATEST
    inputBinding:
      position: 102
      prefix: --high
  - id: indexed
    type:
      - 'null'
      - int
    doc: Minimum number of links in the indexed format
    inputBinding:
      position: 102
      prefix: --indexed
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
      prefix: --layout
  - id: low_bound
    type:
      - 'null'
      - int
    doc: The low bound for library release versions to use when creating objects
      in the file
    default: H5F_LIBVER_EARLIEST
    inputBinding:
      position: 102
      prefix: --low
  - id: metadata_block_size
    type:
      - 'null'
      - int
    doc: Metadata block size for H5Pset_meta_block_size
    inputBinding:
      position: 102
      prefix: --metadata_block_size
  - id: minimum_dataset_size
    type:
      - 'null'
      - int
    doc: Do not apply the filter to datasets smaller than M
    default: 0
    inputBinding:
      position: 102
      prefix: --minimum
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
    default: creation_order
    inputBinding:
      position: 102
      prefix: --sort_by
  - id: sort_order
    type:
      - 'null'
      - string
    doc: Sort groups and attributes by order Z
    default: ascending
    inputBinding:
      position: 102
      prefix: --sort_order
  - id: ssize
    type:
      - 'null'
      - string
    doc: Shared object header message minimum size
    inputBinding:
      position: 102
      prefix: --ssize
  - id: threshold
    type:
      - 'null'
      - int
    doc: Threshold value for H5Pset_alignment
    inputBinding:
      position: 102
      prefix: --threshold
  - id: ublock_file
    type:
      - 'null'
      - File
    doc: Name of file U with user block data to be added
    inputBinding:
      position: 102
      prefix: --ublock
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode, print object information
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type: File
    doc: Output HDF5 File
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hdf5:1.10.4
