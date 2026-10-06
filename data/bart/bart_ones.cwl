cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, ones]
requirements:
  - class: InlineJavascriptRequirement
label: bart_ones
doc: "Create an array filled with ones with {dims} dimensions of size {dim1} to {dimn}.\n\
  \nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: dims
    type: int
    doc: Number of dimensions
    inputBinding:
      position: 10
  - id: dim1
    type: int
    doc: Size of the first dimension
    inputBinding:
      position: 11
  - id: dimn
    type:
      - 'null'
      - type: array
        items: int
    doc: Sizes of subsequent dimensions
    inputBinding:
      position: 12
  - id: name
    type: string
    doc: Name of the output array
    inputBinding:
      position: 13
outputs:
  - id: name_file
    type: File
    doc: Array written as name.cfl/.hdr
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.name).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
