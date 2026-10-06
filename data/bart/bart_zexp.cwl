cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, zexp]
requirements:
  - class: InlineJavascriptRequirement
label: bart_zexp
doc: "Point-wise complex exponential.\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: input
    type: File
    doc: input
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 10
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: output
    type: string
    doc: output
    inputBinding:
      position: 11
  - id: imaginary
    type:
      - 'null'
      - boolean
    doc: imaginary
    inputBinding:
      position: 1
      prefix: -i
outputs:
  - id: output_file
    type: File
    doc: Array written as output.cfl/.hdr
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.output).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
