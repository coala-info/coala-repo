cwlVersion: v1.2
class: CommandLineTool
baseCommand: h5cc
label: hdf5_h5cc
doc: "Compile line for HDF5\n\nTool homepage: https://github.com/HDFGroup/hdf5"
inputs:
  - id: compile_line
    type: string
    doc: the normal compile line options for your compiler.
    inputBinding:
      position: 1
  - id: echo
    type:
      - 'null'
      - boolean
    doc: Show all the shell commands executed
    inputBinding:
      position: 102
      prefix: -echo
  - id: noshlib
    type:
      - 'null'
      - boolean
    doc: Compile with static HDF5 libraries
    inputBinding:
      position: 102
      prefix: -noshlib
  - id: prefix
    type:
      - 'null'
      - Directory
    doc: Prefix directory to find HDF5 lib/ and include/ subdirectories
    default: /usr/local
    inputBinding:
      position: 102
      prefix: -prefix
  - id: shlib
    type:
      - 'null'
      - boolean
    doc: Compile with shared HDF5 libraries
    inputBinding:
      position: 102
      prefix: -shlib
  - id: show
    type:
      - 'null'
      - boolean
    doc: Show the commands without executing them
    inputBinding:
      position: 102
      prefix: -show
  - id: showconfig
    type:
      - 'null'
      - boolean
    doc: Show the HDF5 library configuration summary
    inputBinding:
      position: 102
      prefix: -showconfig
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hdf5:1.10.4
stdout: hdf5_h5cc.out
