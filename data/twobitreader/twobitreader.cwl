cwlVersion: v1.2
class: CommandLineTool
baseCommand: twobitreader
label: twobitreader
doc: "Reads and writes 2bit files.\n\nTool homepage: https://github.com/benjschiller/twobitreader"
inputs:
  - id: input_file
    type: File
    doc: Input 2bit file
    inputBinding:
      position: 1
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'Output file (default: stdout)'
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/twobitreader:3.1.7--py_0
