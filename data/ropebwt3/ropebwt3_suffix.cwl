cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ropebwt3
  - suffix
label: ropebwt3_suffix
doc: "Find the longest matching suffix of query sequences in an FMR/FMD index.\n\nTool homepage: https://github.com/lh3/ropebwt3"
inputs:
  - id: idx_fmr
    type: File
    doc: Input FMR index file
    inputBinding:
      position: 1
  - id: seq_fa
    type: File
    doc: Input FASTA sequence file
    inputBinding:
      position: 2
  - id: one_sequence_per_line
    type:
      - 'null'
      - boolean
    doc: one sequence per line in the input
    inputBinding:
      position: 101
      prefix: -L
  - id: additional_seq_fa
    type:
      - 'null'
      - type: array
        items: File
    doc: Additional FASTA sequence files
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ropebwt3:3.10--h577a1d6_0
stdout: ropebwt3_suffix.out
