cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mehari
  - db
  - dump
label: mehari_db_dump
doc: "Dump transcript database\n\nTool homepage: https://github.com/varfish-org/mehari"
inputs:
  - id: path_db
    type: File
    doc: "Path to database file to dump"
    inputBinding:
      position: 1
      prefix: --path-db
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Increase logging verbosity"
    inputBinding:
      position: 2
      prefix: --verbose
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Decrease logging verbosity"
    inputBinding:
      position: 3
      prefix: --quiet
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mehari:0.39.0--h13c227e_0
stdout: mehari_db_dump.out
