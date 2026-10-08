cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtt-parse-fasta-by-headers
label: gtotree_gtt-parse-fasta-by-headers
doc: "Parses a fasta file by pulling out sequences with the desired headers (or all other sequences with --inverse).

Tool homepage: https://github.com/AstrobioMike/GToTree"
inputs:
  - id: input_fasta
    type: File
    doc: "Original fasta file"
    inputBinding:
      position: 1
      prefix: -i
  - id: wanted_headers
    type: File
    doc: "Single-column file with sequence headers"
    inputBinding:
      position: 2
      prefix: -w
  - id: output_fasta
    type:
      - 'null'
      - string
    doc: "Output fasta file"
    default: Wanted.fa
    inputBinding:
      position: 3
      prefix: -o
  - id: inverse
    type:
      - 'null'
      - boolean
    doc: "Pull out all sequences with headers NOT in the provided header file"
    inputBinding:
      position: 4
      prefix: --inverse
outputs:
  - id: output_fa
    type: File
    doc: "Parsed fasta file"
    outputBinding:
      glob: $(inputs.output_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtotree:1.8.16--h9ee0642_2
