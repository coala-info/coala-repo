cwlVersion: v1.2
class: CommandLineTool
baseCommand: bart_std
label: bart_std
doc: "Compute standard deviation along selected dimensions specified by the {bitmask}\n\
  \nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: bitmask
    type: string
    doc: bitmask
    inputBinding:
      position: 1
  - id: input
    type: File
    doc: input
    inputBinding:
      position: 2
outputs:
  - id: output
    type: File
    doc: output
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
