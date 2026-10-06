cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, index]
requirements:
  - class: InlineJavascriptRequirement
label: bart_index
doc: "Create an array counting from 0 to {size-1} in dimensions {dim}.\n\nTool homepage:
  https://github.com/mrirecon/bart"
inputs:
  - id: dim
    type: int
    doc: Dimensions
    inputBinding:
      position: 10
  - id: size
    type: int
    doc: Size
    inputBinding:
      position: 11
  - id: name
    type: string
    doc: Name
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
