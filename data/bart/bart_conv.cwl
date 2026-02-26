cwlVersion: v1.2
class: CommandLineTool
baseCommand: conv
label: bart_conv
doc: "Performs a convolution along selected dimensions.\n\nTool homepage: https://github.com/tomdstanton/bart"
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
  - id: kernel
    type: File
    doc: kernel
    inputBinding:
      position: 3
outputs:
  - id: output
    type: File
    doc: output
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
