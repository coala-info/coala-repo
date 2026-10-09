cwlVersion: v1.2
class: CommandLineTool
baseCommand: h5mkgrp
label: hdf5_h5mkgrp
doc: "Creates new groups in an existing HDF5 file.\n\nTool homepage: https://github.com/HDFGroup/hdf5"
inputs:
  - id: input_file
    type: File
    doc: HDF5 file in which the groups are created (copied to the working directory and modified there)
    inputBinding:
      position: 200
      valueFrom: $(self.basename)
  - id: groups
    type:
      type: array
      items: string
    doc: Names of the groups to create
    inputBinding:
      position: 201
  - id: latest
    type:
      - 'null'
      - boolean
    doc: Use latest version of file format to create groups
    inputBinding:
      position: 101
      prefix: -l
  - id: parents
    type:
      - 'null'
      - boolean
    doc: No error if existing, make parent groups as needed
    inputBinding:
      position: 101
      prefix: -p
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print information about OBJECTS and OPTIONS
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_file
    type: File
    doc: HDF5 file with the new groups
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
stdout: hdf5_h5mkgrp.out
