cwlVersion: v1.2
class: CommandLineTool
baseCommand: filter
label: bart_filter
doc: "Apply filter.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: input
    type: File
    doc: input
    inputBinding:
      position: 1
  - id: filter_length
    type:
      - 'null'
      - string
    doc: length of filter
    inputBinding:
      position: 102
      prefix: -l
  - id: median_filter_dim
    type:
      - 'null'
      - string
    doc: median filter along dimension dim
    inputBinding:
      position: 102
      prefix: -m
outputs:
  - id: output
    type: File
    doc: output
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
