cwlVersion: v1.2
class: CommandLineTool
baseCommand: mmft_merge
label: mmft_merge
doc: "Merge sequence records within/between fasta files into a single fasta record.\n\
  \nTool homepage: https://github.com/ARU-life-sciences/mmft"
inputs:
  - id: fastas
    type:
      - 'null'
      - type: array
        items: File
    doc: Input fasta file path(s).
    inputBinding:
      position: 1
  - id: header
    type:
      - 'null'
      - string
    doc: Name of output fasta header.
    inputBinding:
      position: 102
      prefix: --header
  - id: track
    type:
      - 'null'
      - boolean
    doc: Keep track of record indexes in fasta header
    inputBinding:
      position: 102
      prefix: --track
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmft:0.3.2--hc1c3326_0
stdout: mmft_merge.out
