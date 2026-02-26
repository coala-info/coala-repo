cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ropebwt3
  - fa2line
label: ropebwt3_fa2line
doc: "Convert FASTA file to line-based format\n\nTool homepage: https://github.com/lh3/ropebwt3"
inputs:
  - id: seq_fa
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: additional_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Additional FASTA files
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ropebwt3:3.10--h577a1d6_0
stdout: ropebwt3_fa2line.out
