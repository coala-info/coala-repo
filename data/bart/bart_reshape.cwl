cwlVersion: v1.2
class: CommandLineTool
baseCommand: bart_reshape
label: bart_reshape
doc: "Reshapes an array to new dimensions.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: flags
    type: string
    doc: Flags for reshaping
    inputBinding:
      position: 1
  - id: dim1
    type: int
    doc: First dimension
    inputBinding:
      position: 2
  - id: dimN
    type:
      type: array
      items: int
    doc: Subsequent dimensions
    inputBinding:
      position: 3
  - id: input
    type: File
    doc: Input file
    inputBinding:
      position: 4
outputs:
  - id: output
    type: File
    doc: Output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
