cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, reshape]
requirements:
  - class: InlineJavascriptRequirement
label: bart_reshape
doc: "Reshapes an array to new dimensions.\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: flags
    type: string
    doc: Flags for reshaping
    inputBinding:
      position: 10
  - id: dim1
    type: int
    doc: First dimension
    inputBinding:
      position: 11
  - id: dimN
    type:
      type: array
      items: int
    doc: Subsequent dimensions
    inputBinding:
      position: 12
  - id: input
    type: File
    doc: Input file
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 13
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: output_name
    type: string
    doc: Output name without extension (writes <name>.cfl and <name>.hdr)
    inputBinding:
      position: 14
outputs:
  - id: output
    type: File
    doc: Output file
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.output_name).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
