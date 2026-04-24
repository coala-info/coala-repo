cwlVersion: v1.2
class: CommandLineTool
baseCommand: h5c++
label: hdf5_h5c++
doc: "Compile line for HDF5 C++ programs\n\nTool homepage: https://github.com/HDFGroup/hdf5"
inputs:
  - id: compile_line
    type: string
    doc: The normal compile line options for your compiler. h5c++ uses the same 
      compiler you used to compile HDF5. Check with your compiler's man pages 
      for more information on which options are needed.
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
    doc: Compile with static HDF5 libraries [default for hdf5 built with static 
      libraries]
    inputBinding:
      position: 102
      prefix: -noshlib
  - id: prefix
    type:
      - 'null'
      - Directory
    doc: Prefix directory to find HDF5 lib/ and include/ subdirectories
    inputBinding:
      position: 102
      prefix: -prefix
  - id: shlib
    type:
      - 'null'
      - boolean
    doc: Compile with shared HDF5 libraries [default for hdf5 built without 
      static libraries]
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
stdout: hdf5_h5c++.out
