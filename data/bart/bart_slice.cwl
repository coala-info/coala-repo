cwlVersion: v1.2
class: CommandLineTool
baseCommand: bart_slice
label: bart_slice
doc: "Extracts a slice from {position} along {dimension}.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: dimension
    type: string
    doc: The dimension along which to slice.
    inputBinding:
      position: 1
  - id: position
    type: int
    doc: The position along the specified dimension to slice at.
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
