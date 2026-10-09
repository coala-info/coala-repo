cwlVersion: v1.2
class: CommandLineTool
baseCommand: h5stat
label: hdf5_h5stat
doc: "Prints statistics about an HDF5 file: file, group, dataset, datatype and attribute information.\n\nTool homepage: https://github.com/HDFGroup/hdf5"
inputs:
  - id: input_file
    type: File
    doc: Input HDF5 file
    inputBinding:
      position: 200
  - id: file_info
    type:
      - 'null'
      - boolean
    doc: Print file information
    inputBinding:
      position: 101
      prefix: -f
  - id: file_metadata
    type:
      - 'null'
      - boolean
    doc: Print file space information for file's metadata
    inputBinding:
      position: 101
      prefix: -F
  - id: group_info
    type:
      - 'null'
      - boolean
    doc: Print group information
    inputBinding:
      position: 101
      prefix: -g
  - id: links_threshold
    type:
      - 'null'
      - int
    doc: Set the threshold for the # of links when printing information for small groups. N is an integer greater than 0. The default threshold is 10.
    inputBinding:
      position: 101
      prefix: -l
  - id: group_metadata
    type:
      - 'null'
      - boolean
    doc: Print file space information for groups' metadata
    inputBinding:
      position: 101
      prefix: -G
  - id: dset_info
    type:
      - 'null'
      - boolean
    doc: Print dataset information
    inputBinding:
      position: 101
      prefix: -d
  - id: dims_threshold
    type:
      - 'null'
      - int
    doc: Set the threshold for the dimension sizes when printing information for small datasets. N is an integer greater than 0. The default threshold is 10.
    inputBinding:
      position: 101
      prefix: -m
  - id: dset_metadata
    type:
      - 'null'
      - boolean
    doc: Print file space information for datasets' metadata
    inputBinding:
      position: 101
      prefix: -D
  - id: dtype_metadata
    type:
      - 'null'
      - boolean
    doc: Print datasets' datatype information
    inputBinding:
      position: 101
      prefix: -T
  - id: attribute_info
    type:
      - 'null'
      - boolean
    doc: Print attribute information
    inputBinding:
      position: 101
      prefix: -A
  - id: numattrs_threshold
    type:
      - 'null'
      - int
    doc: Set the threshold for the # of attributes when printing information for small # of attributes. N is an integer greater than 0. The default threshold is 10.
    inputBinding:
      position: 101
      prefix: -a
  - id: freespace
    type:
      - 'null'
      - boolean
    doc: Print free space information
    inputBinding:
      position: 101
      prefix: -s
  - id: summary
    type:
      - 'null'
      - boolean
    doc: Print summary of file space information
    inputBinding:
      position: 101
      prefix: -S
  - id: enable_error_stack
    type:
      - 'null'
      - boolean
    doc: Prints messages from the HDF5 error stack as they occur
    inputBinding:
      position: 101
      prefix: --enable-error-stack
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hdf5:1.10.4
stdout: hdf5_h5stat.out
