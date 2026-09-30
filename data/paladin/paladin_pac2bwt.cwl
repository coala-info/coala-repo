cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - paladin
  - pac2bwt
label: paladin_pac2bwt
doc: "Generate a BWT from a PAC file using PALADIN\n\nTool homepage: https://github.com/ToniWestbrook/paladin"
inputs:
  - id: input_pac
    type: File
    doc: Input PAC file
    inputBinding:
      position: 1
  - id: out_bwt
    type: string
    doc: Output BWT file
    inputBinding:
      position: 2
outputs:
  - id: output_bwt
    type: File
    doc: Output BWT file
    outputBinding:
      glob: '$(inputs.out_bwt)'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/paladin:1.6.0--h44aa6d8_0
