cwlVersion: v1.2
class: CommandLineTool
baseCommand: cdf97
label: bart_cdf97
doc: "Perform a wavelet (cdf97) transform.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: bitmask
    type: string
    doc: bitmask
    inputBinding:
      position: 1
  - id: input
    type: File
    doc: input
    inputBinding:
      position: 2
  - id: inverse
    type:
      - 'null'
      - boolean
    doc: inverse
    inputBinding:
      position: 103
      prefix: -i
outputs:
  - id: output
    type: File
    doc: output
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
