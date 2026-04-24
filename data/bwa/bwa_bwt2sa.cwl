cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwa
  - bwt2sa
label: bwa_bwt2sa
doc: "Generate suffix array from BWT\n\nTool homepage: https://github.com/lh3/bwa"
inputs:
  - id: in_bwt
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
  - id: out_sa
    type: File
    doc: Output suffix array file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwa:0.7.19--h577a1d6_1
