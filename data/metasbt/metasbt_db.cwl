cwlVersion: v1.2
class: CommandLineTool
baseCommand: db
label: metasbt_db
doc: "List and retrieve public MetaSBT databases.\n\nTool homepage: https://github.com/cumbof/MetaSBT"
inputs:
  - id: download
    type: string
    doc: The database name.
    default: None
    inputBinding:
      position: 101
      prefix: --download
  - id: folder
    type:
      - 'null'
      - Directory
    doc: Store the selected database under this folder.
    default: /
    inputBinding:
      position: 101
      prefix: --folder
  - id: list
    type:
      - 'null'
      - boolean
    doc: List official public MetaSBT databases.
    default: false
    inputBinding:
      position: 101
      prefix: --list
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metasbt:0.1.5--pyhdfd78af_0
stdout: metasbt_db.out
