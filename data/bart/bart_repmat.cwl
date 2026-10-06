cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, repmat]
requirements:
  - class: InlineJavascriptRequirement
label: bart_repmat
doc: "Repeat input array multiple times along a certain dimension.\n\nTool homepage:
  https://github.com/mrirecon/bart"
inputs:
  - id: dimension
    type: int
    doc: Dimension along which to repeat
    inputBinding:
      position: 10
  - id: repetitions
    type: int
    doc: Number of repetitions
    inputBinding:
      position: 11
  - id: input
    type: File
    doc: Input array
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
    doc: Output array
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.output_name).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
