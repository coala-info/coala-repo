cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, wavelet]
requirements:
  - class: InlineJavascriptRequirement
label: bart_wavelet
doc: "Perform wavelet transform.\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: flags
    type: string
    doc: flags
    inputBinding:
      position: 10
  - id: dims
    type:
      - 'null'
      - type: array
        items: int
    doc: dims
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
  - id: adjoint
    type:
      - 'null'
      - boolean
    doc: adjoint (specify dims)
    inputBinding:
      position: 1
      prefix: -a
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
