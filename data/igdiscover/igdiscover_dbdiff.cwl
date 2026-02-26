cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - igdiscover
  - dbdiff
label: igdiscover_dbdiff
doc: "Compare two FASTA files based on sequences\n\nTool homepage: https://igdiscover.se/"
inputs:
  - id: a
    type: File
    doc: FASTA file with expected sequences
    inputBinding:
      position: 1
  - id: b
    type: File
    doc: FASTA file with actual sequences
    inputBinding:
      position: 2
  - id: color
    type:
      - 'null'
      - string
    doc: Whether to colorize output
    default: auto
    inputBinding:
      position: 103
      prefix: --color
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igdiscover:0.15.1--pyhdfd78af_2
stdout: igdiscover_dbdiff.out
