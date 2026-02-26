cwlVersion: v1.2
class: CommandLineTool
baseCommand: bart_transpose
label: bart_transpose
doc: "Transpose a 3D array.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: dim1
    type: int
    doc: The first dimension to transpose.
    inputBinding:
      position: 1
  - id: dim2
    type: int
    doc: The second dimension to transpose.
    inputBinding:
      position: 2
  - id: input
    type: File
    doc: Input file.
    inputBinding:
      position: 3
outputs:
  - id: output
    type: File
    doc: Output file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
