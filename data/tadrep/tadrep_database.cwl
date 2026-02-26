cwlVersion: v1.2
class: CommandLineTool
baseCommand: tadrep_database
label: tadrep_database
doc: "Import external databases for TaDReP.\n\nTool homepage: https://github.com/oschwengers/tadrep"
inputs:
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force download and new setup of database
    inputBinding:
      position: 101
      prefix: --force
  - id: type
    type:
      - 'null'
      - string
    doc: External DB to import (default = 'refseq')
    default: refseq
    inputBinding:
      position: 101
      prefix: --type
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tadrep:0.9.2--pyhdfd78af_0
stdout: tadrep_database.out
