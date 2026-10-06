cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, rof]
requirements:
  - class: InlineJavascriptRequirement
label: bart_rof
doc: "Perform total variation denoising along dims <flags>.\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: lambda
    type: float
    doc: lambda
    inputBinding:
      position: 10
  - id: flags
    type: string
    doc: flags
    inputBinding:
      position: 11
  - id: input
    type: File
    doc: input
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
