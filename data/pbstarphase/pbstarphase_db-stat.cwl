cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pbstarphase
  - db-stat
label: pbstarphase_db-stat
doc: "Generate statistics about a database file\n\nTool homepage: https://github.com/PacificBiosciences/pb-StarPhase"
inputs:
  - id: database
    type: File
    doc: Input database file (JSON)
    inputBinding:
      position: 101
      prefix: --database
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Enable verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbstarphase:2.0.1--h9ee0642_0
stdout: pbstarphase_db-stat.out
