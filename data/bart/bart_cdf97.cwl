cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, cdf97]
requirements:
  - class: InlineJavascriptRequirement
label: bart_cdf97
doc: "Perform a wavelet (cdf97) transform.\n\nTool homepage: https://github.com/mrirecon/bart"
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
  - id: output_name
    type: string
    doc: Output name without extension (writes <name>.cfl and <name>.hdr)
    inputBinding:
      position: 12
  - id: inverse
    type:
      - 'null'
      - boolean
    doc: inverse
    inputBinding:
      position: 1
      prefix: -i
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
