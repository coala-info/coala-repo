cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, window]
requirements:
  - class: InlineJavascriptRequirement
label: bart_window
doc: "Apply Hamming (Hann) window to <input> along dimensions specified by flags\n\
  \nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: flags
    type: string
    doc: dimensions specified by flags
    inputBinding:
      position: 10
  - id: input
    type: File
    doc: input file
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
  - id: hann_window
    type:
      - 'null'
      - boolean
    doc: Hann window
    inputBinding:
      position: 1
      prefix: -H
outputs:
  - id: output
    type: File
    doc: output file
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.output_name).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
