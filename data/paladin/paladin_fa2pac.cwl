cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwa
  - fa2pac
label: paladin_fa2pac
doc: "Convert FASTA to PAC format\n\nTool homepage: https://github.com/ToniWestbrook/paladin"
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
    doc: Force overwrite or specific flag for fa2pac
    inputBinding:
      position: 102
      prefix: -f
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: Output prefix for the generated files
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/paladin:1.6.0--h44aa6d8_0
