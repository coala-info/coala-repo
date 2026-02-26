cwlVersion: v1.2
class: CommandLineTool
baseCommand: bart_crop
label: bart_crop
doc: "Extracts a sub-array corresponding to the central part of {size} along {dimension}\n\
  \nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: dimension
    type: string
    doc: The dimension along which to extract the sub-array
    inputBinding:
      position: 1
  - id: size
    type: int
    doc: The size of the sub-array to extract
    inputBinding:
      position: 2
  - id: input
    type: File
    doc: The input array file
    inputBinding:
      position: 3
outputs:
  - id: output
    type: File
    doc: The output array file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
