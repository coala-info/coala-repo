cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, conv]
requirements:
  - class: InlineJavascriptRequirement
label: bart_conv
doc: "Performs a convolution along selected dimensions.\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: bitmask
    type: string
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
  - id: kernel
    type: File
    doc: kernel
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
    doc: output
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.output_name).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
