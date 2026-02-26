cwlVersion: v1.2
class: CommandLineTool
baseCommand: bart_ones
label: bart_ones
doc: "Create an array filled with ones with {dims} dimensions of size {dim1} to {dimn}.\n\
  \nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: dims
    type: int
    doc: Number of dimensions
    inputBinding:
      position: 1
  - id: dim1
    type: int
    doc: Size of the first dimension
    inputBinding:
      position: 2
  - id: dimn
    type:
      type: array
      items: int
    doc: Sizes of subsequent dimensions
    inputBinding:
      position: 3
  - id: name
    type: string
    doc: Name of the output array
    inputBinding:
      position: 4
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
stdout: bart_ones.out
