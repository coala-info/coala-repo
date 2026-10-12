cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cmph5tools.py
  - equal
label: pbh5tools_cmph5tools_equal
doc: "Compare two cmp.h5 files for equivalence. The exit code is 1 when the files differ.\n\nTool homepage: https://github.com/PacificBiosciences/pbh5tools"
inputs:
  - id: cmp_h5_1
    type: File
    doc: filename 1
    inputBinding:
      position: 1
  - id: cmp_h5_2
    type: File
    doc: filename 2
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
stdout: pbh5tools_cmph5tools_equal_stdout.txt
successCodes:
  - 0
  - 1
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbh5tools:0.8.0--py27h470a237_1
