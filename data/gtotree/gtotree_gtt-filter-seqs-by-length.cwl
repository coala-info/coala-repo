cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtt-filter-seqs-by-length
label: gtotree_gtt-filter-seqs-by-length
doc: "Takes a multifasta as input and filters out sequences based on length.

Tool homepage: https://github.com/AstrobioMike/GToTree"
inputs:
  - id: input_fasta
    type: File
    doc: "Original fasta file"
    inputBinding:
      position: 1
      prefix: -i
  - id: min_length
    type: int
    doc: "minimum length retained"
    inputBinding:
      position: 2
      prefix: -m
  - id: max_length
    type: int
    doc: "maximum length retained"
    inputBinding:
      position: 3
      prefix: -M
  - id: output_file
    type:
      - 'null'
      - string
    doc: "name of output fasta file"
    default: filtered.fasta
    inputBinding:
      position: 4
      prefix: -o
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "don't report percentage of retained sequences"
    inputBinding:
      position: 5
      prefix: -q
outputs:
  - id: output_fasta
    type: File
    doc: "Filtered fasta file"
    outputBinding:
      glob: $(inputs.output_file)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtotree:1.8.16--h9ee0642_2
stdout: gtotree_gtt-filter-seqs-by-length.out
