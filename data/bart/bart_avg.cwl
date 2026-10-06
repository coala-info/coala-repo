cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, avg]
requirements:
  - class: InlineJavascriptRequirement
label: bart_avg
doc: "Calculates (weighted) average along dimensions specified by bitmask.\n\nTool
  homepage: https://github.com/mrirecon/bart"
inputs:
  - id: bitmask
    type: string
    doc: Bitmask specifying dimensions for averaging
    inputBinding:
      position: 10
  - id: input
    type: File
    doc: Input file
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
  - id: weighted_average
    type:
      - 'null'
      - boolean
    doc: weighted average
    inputBinding:
      position: 1
      prefix: -w
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
