cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwa
  - fa2pac
label: bwa_fa2pac
doc: "Convert FASTA format to PAC format for BWA indexing\n\nTool homepage: https://github.com/lh3/bwa"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: f_flag
    type:
      - 'null'
      - boolean
    doc: Force overwrite of existing files
    inputBinding:
      position: 102
      prefix: -f
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: Prefix for the output files
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwa:0.7.19--h577a1d6_1
