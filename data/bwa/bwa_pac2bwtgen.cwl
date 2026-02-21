cwlVersion: v1.2
class: CommandLineTool
baseCommand: bwtgen
label: bwa_pac2bwtgen
doc: "Generate a BWT from a PAC file\n\nTool homepage: https://github.com/lh3/bwa"
inputs:
  - id: input_pac
    type: File
    doc: Input PAC file
    inputBinding:
      position: 1
outputs:
  - id: output_bwt
    type: File
    doc: Output BWT file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwa:0.7.19--h577a1d6_1
