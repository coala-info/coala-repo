cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtt-reorder-fasta
label: gtotree_gtt-reorder-fasta
doc: "Takes a multifasta file and reorders the sequences according to the headers provided.

Tool homepage: https://github.com/AstrobioMike/GToTree"
inputs:
  - id: input_fasta
    type: File
    doc: "Original fasta file"
    inputBinding:
      position: 1
      prefix: -i
  - id: ordered_headers
    type: File
    doc: "Single-column file with headers in desired order"
    inputBinding:
      position: 2
      prefix: -w
  - id: output_fasta
    type:
      - 'null'
      - string
    doc: "Reordered output fasta"
    default: Reordered.fa
    inputBinding:
      position: 3
      prefix: -o
outputs:
  - id: reordered_fasta
    type: File
    doc: "Reordered fasta file"
    outputBinding:
      glob: $(inputs.output_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtotree:1.8.16--h9ee0642_2
