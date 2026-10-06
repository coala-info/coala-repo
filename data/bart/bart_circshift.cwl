cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, circshift]
requirements:
  - class: InlineJavascriptRequirement
label: bart_circshift
doc: "Perform circular shift along {dim} by {shift} elements.\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: dim
    type: string
    doc: Dimension to shift along
    inputBinding:
      position: 10
  - id: shift
    type: int
    doc: Number of elements to shift by
    inputBinding:
      position: 11
  - id: input
    type: File
    doc: Input file
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 12
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: output_name
    type: string
    doc: Output name without extension (writes <name>.cfl and <name>.hdr)
    inputBinding:
      position: 13
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
