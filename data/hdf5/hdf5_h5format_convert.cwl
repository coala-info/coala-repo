cwlVersion: v1.2
class: CommandLineTool
baseCommand: h5format_convert
label: hdf5_h5format_convert
doc: "Converts the chunk indexing type or the layout version of datasets in an HDF5 file to the older format (version 1 B-tree, layout version 3).\n\nTool homepage: https://github.com/HDFGroup/hdf5"
inputs:
  - id: input_file
    type: File
    doc: HDF5 file to convert (copied to the working directory and modified there)
    inputBinding:
      position: 200
      valueFrom: $(self.basename)
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Turn on verbose mode
    inputBinding:
      position: 101
      prefix: -v
  - id: dataset_name
    type:
      - 'null'
      - string
    doc: Pathname for the dataset
    inputBinding:
      position: 101
      prefix: '--dname='
      separate: false
  - id: noop
    type:
      - 'null'
      - boolean
    doc: Perform all the steps except the actual conversion
    inputBinding:
      position: 101
      prefix: -n
outputs:
  - id: output_file
    type: File
    doc: HDF5 file after the conversion
    outputBinding:
      glob: $(inputs.input_file.basename)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hdf5:1.10.4
stdout: hdf5_h5format_convert.out
