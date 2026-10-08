cwlVersion: v1.2
class: CommandLineTool
baseCommand: [gfatools, sql]
label: gfatools_sql
doc: "Export an rGFA graph to SQLite statements (written to standard output).\n\nTool homepage: https://github.com/lh3/gfatools"
inputs:
  - id: write_sequence
    type:
      - 'null'
      - boolean
    doc: "write sequence"
    inputBinding:
      position: 1
      prefix: -s
  - id: input_gfa
    type: File
    doc: "Input rGFA file"
    inputBinding:
      position: 200
outputs:
  - id: stdout
    type: stdout
    doc: "SQL statements"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfatools:0.5.5--h577a1d6_0
stdout: gfatools_sql.sql
