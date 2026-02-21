cwlVersion: v1.2
class: CommandLineTool
baseCommand: diamond dbinfo
label: diamond_dbinfo
doc: "Display information about a DIAMOND database file\n\nTool homepage: https://github.com/bbuchfink/diamond"
inputs:
  - id: db
    type:
      - 'null'
      - File
    doc: database file
    inputBinding:
      position: 101
      prefix: --db
  - id: log
    type:
      - 'null'
      - boolean
    doc: enable debug log
    inputBinding:
      position: 101
      prefix: --log
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: disable console output
    inputBinding:
      position: 101
      prefix: --quiet
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPU threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: directory for temporary files
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose console output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/diamond:2.1.21--h13889ed_0
stdout: diamond_dbinfo.out
