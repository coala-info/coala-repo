cwlVersion: v1.2
class: CommandLineTool
baseCommand: ropebwt3 suffix
label: ropebwt3_suffix
doc: "Build suffix array and BWT for a FASTA file.\n\nTool homepage: https://github.com/lh3/ropebwt3"
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
