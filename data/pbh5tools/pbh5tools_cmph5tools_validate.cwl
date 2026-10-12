cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cmph5tools.py
  - validate
label: pbh5tools_cmph5tools_validate
doc: "Validate a cmp.h5 file.\n\nTool homepage: https://github.com/PacificBiosciences/pbh5tools"
inputs:
  - id: input_cmp_h5
    type: File
    doc: input filename
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
stdout: pbh5tools_cmph5tools_validate_stdout.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbh5tools:0.8.0--py27h470a237_1
