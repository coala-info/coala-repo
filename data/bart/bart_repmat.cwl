cwlVersion: v1.2
class: CommandLineTool
baseCommand: repmat
label: bart_repmat
doc: "Repeat input array multiple times along a certain dimension.\n\nTool homepage:
  https://github.com/tomdstanton/bart"
inputs:
  - id: dimension
    type: int
    doc: Dimension along which to repeat
    inputBinding:
      position: 1
  - id: repetitions
    type: int
    doc: Number of repetitions
    inputBinding:
      position: 2
  - id: input
    type: File
    doc: Input array
    inputBinding:
      position: 3
outputs:
  - id: output
    type: File
    doc: Output array
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
