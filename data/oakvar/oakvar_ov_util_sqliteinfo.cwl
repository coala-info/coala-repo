cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ov
  - util
  - sqliteinfo
label: oakvar_ov_util_sqliteinfo
doc: "Shows SQLite result file information.\n\nTool homepage: http://www.oakvar.com"
inputs:
  - id: dbpath
    type: File
    doc: SQLite result file path.
    inputBinding:
      position: 1
  - id: fmt
    type:
      - 'null'
      - string
    doc: Output format. text / json / yaml.
    inputBinding:
      position: 102
      prefix: --fmt
outputs:
  - id: stdout
    type: stdout
    doc: Result file information, printed to standard output.
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oakvar:2.12.25--pyhdfd78af_0
stdout: oakvar_ov_util_sqliteinfo.out
