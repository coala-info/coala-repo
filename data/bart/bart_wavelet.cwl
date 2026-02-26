cwlVersion: v1.2
class: CommandLineTool
baseCommand: wavelet
label: bart_wavelet
doc: "Perform wavelet transform.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: flags
    type: string
    doc: flags
    inputBinding:
      position: 1
  - id: dims
    type:
      - 'null'
      - string
    doc: dims
    inputBinding:
      position: 2
  - id: input
    type: File
    doc: input
    inputBinding:
      position: 3
  - id: adjoint
    type:
      - 'null'
      - boolean
    doc: adjoint (specify dims)
    inputBinding:
      position: 104
      prefix: -a
outputs:
  - id: output
    type: File
    doc: output
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
