cwlVersion: v1.2
class: CommandLineTool
baseCommand: combine
label: moreutils_combine
doc: "Combine the lines in two files using boolean operations (and, or, not, xor).\n
  \nTool homepage: https://github.com/madx/moreutils"
inputs:
  - id: file1
    type: File
    doc: First input file
    inputBinding:
      position: 1
  - id: operation
    type: string
    doc: 'Boolean operation to perform: and, or, not, or xor'
    inputBinding:
      position: 2
  - id: file2
    type: File
    doc: Second input file
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moreutils:0.5.7--1
stdout: moreutils_combine.out
