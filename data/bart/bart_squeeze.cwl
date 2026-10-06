cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, squeeze]
requirements:
  - class: InlineJavascriptRequirement
label: bart_squeeze
doc: "Squeezes a BART file.\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: input
    type: File
    doc: Input BART file
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 10
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: output_name
    type: string
    doc: Output name without extension (writes <name>.cfl and <name>.hdr)
    inputBinding:
      position: 11
outputs:
  - id: output
    type: File
    doc: Output BART file
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.output_name).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
