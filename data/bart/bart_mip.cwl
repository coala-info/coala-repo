cwlVersion: v1.2
class: CommandLineTool
baseCommand: mip
label: bart_mip
doc: "Maximum (minimum) intensity projection (MIP) along dimensions specified by bitmask.\n\
  \nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: bitmask
    type: int
    doc: bitmask
    inputBinding:
      position: 1
  - id: input
    type: File
    doc: input
    inputBinding:
      position: 2
  - id: absolute_value
    type:
      - 'null'
      - boolean
    doc: do absolute value first
    inputBinding:
      position: 103
      prefix: -a
  - id: minimum
    type:
      - 'null'
      - boolean
    doc: minimum
    inputBinding:
      position: 103
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
