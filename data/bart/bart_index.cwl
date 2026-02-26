cwlVersion: v1.2
class: CommandLineTool
baseCommand: bart_index
label: bart_index
doc: "Create an array counting from 0 to {size-1} in dimensions {dim}.\n\nTool homepage:
  https://github.com/tomdstanton/bart"
inputs:
  - id: dim
    type: int
    doc: Dimensions
    inputBinding:
      position: 1
  - id: size
    type: int
    doc: Size
    inputBinding:
      position: 2
  - id: name
    type: string
    doc: Name
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
stdout: bart_index.out
