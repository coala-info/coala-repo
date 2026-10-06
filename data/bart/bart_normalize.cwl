cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, normalize]
requirements:
  - class: InlineJavascriptRequirement
label: bart_normalize
doc: "Normalize input data\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: flags
    type: string
    doc: Flags for normalization
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
