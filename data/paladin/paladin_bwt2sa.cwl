cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - paladin
  - bwt2sa
label: paladin_bwt2sa
doc: "Generate a suffix array (.sa) from a BWT index (.bwt) using PALADIN\n\nTool
  homepage: https://github.com/ToniWestbrook/paladin"
inputs:
  - id: input_bwt
    type: File
    doc: Input BWT file
    inputBinding:
      position: 1
  - id: sampling_interval
    type:
      - 'null'
      - int
    doc: Sampling interval
    inputBinding:
      position: 102
      prefix: -i
outputs:
  - id: output_sa
    type: File
    doc: Output suffix array file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/paladin:1.6.0--h44aa6d8_0
