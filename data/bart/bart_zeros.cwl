cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, zeros]
requirements:
  - class: InlineJavascriptRequirement
label: bart_zeros
doc: "Create a zero-filled array with {dims} dimensions of size {dim1} to {dimn}.\n\
  \nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: dims
    type: int
    doc: Number of dimensions
    inputBinding:
      position: 10
  - id: dim1
    type:
      type: array
      items: int
    doc: Size of dimension 1
    inputBinding:
      position: 11
  - id: name
    type: string
    doc: Name of the output array
    inputBinding:
      position: 12
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
