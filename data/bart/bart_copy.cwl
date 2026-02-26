cwlVersion: v1.2
class: CommandLineTool
baseCommand: copy
label: bart_copy
doc: "Copy an array (to a given position in the output file - which then must exist).\n\
  \nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: dimensions_positions
    type:
      - 'null'
      - type: array
        items: string
    doc: Dimensions and their positions
    inputBinding:
      position: 1
  - id: input
    type: File
    doc: Input array
    inputBinding:
      position: 2
outputs:
  - id: output
    type: File
    doc: Output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
