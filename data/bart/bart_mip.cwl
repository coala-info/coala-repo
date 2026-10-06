cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, mip]
requirements:
  - class: InlineJavascriptRequirement
label: bart_mip
doc: "Maximum (minimum) intensity projection (MIP) along dimensions specified by bitmask.\n\
  \nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: bitmask
    type: int
    doc: bitmask
    inputBinding:
      position: 10
  - id: input
    type: File
    doc: input
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 11
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: output_name
    type: string
    doc: Output name without extension (writes <name>.cfl and <name>.hdr)
    inputBinding:
      position: 12
  - id: absolute_value
    type:
      - 'null'
      - boolean
    doc: do absolute value first
    inputBinding:
      position: 1
      prefix: -a
  - id: minimum
    type:
      - 'null'
      - boolean
    doc: minimum
    inputBinding:
      position: 1
      prefix: -m
outputs:
  - id: output
    type: File
    doc: output
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.output_name).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
