cwlVersion: v1.2
class: CommandLineTool
baseCommand: circshift
label: bart_circshift
doc: "Perform circular shift along {dim} by {shift} elements.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: dim
    type: string
    doc: Dimension to shift along
    inputBinding:
      position: 1
  - id: shift
    type: int
    doc: Number of elements to shift by
    inputBinding:
      position: 2
  - id: input
    type: File
    doc: Input file
    inputBinding:
      position: 3
outputs:
  - id: output
    type: File
    doc: Output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
