cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwa
  - pac2bwt
label: bwa-aln-interactive_pac2bwt
doc: "Convert a PAC file to a BWT file.\n\nTool homepage: https://github.com/fulcrumgenomics/bwa-aln-interactive"
inputs:
  - id: input_pac
    type: File
    doc: Input PAC file
    inputBinding:
      position: 1
  - id: d_flag
    type:
      - 'null'
      - boolean
    doc: Optional flag -d
    inputBinding:
      position: 102
      prefix: -d
outputs:
  - id: output_bwt
    type: File
    doc: Output BWT file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwa-aln-interactive:0.7.18--h577a1d6_2
