cwlVersion: v1.2
class: CommandLineTool
baseCommand: bart_zeros
label: bart_zeros
doc: "Create a zero-filled array with {dims} dimensions of size {dim1} to {dimn}.\n\
  \nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: dims
    type: int
    doc: Number of dimensions
    inputBinding:
      position: 1
  - id: dim1
    type:
      type: array
      items: int
    doc: Size of dimension 1
    inputBinding:
      position: 2
  - id: name
    type: string
    doc: Name of the output array
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
stdout: bart_zeros.out
