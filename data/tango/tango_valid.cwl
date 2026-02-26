cwlVersion: v1.2
class: CommandLineTool
baseCommand: tango
label: tango_valid
doc: "tango: error: invalid choice: 'valid' (choose from 'download', 'format', 'update',
  'build', 'search', 'assign', 'transfer')\n\nTool homepage: https://github.com/johnne/tango"
inputs:
  - id: command
    type:
      type: array
      items: string
    doc: 'Subcommand to execute. Available choices: download, format, update, build,
      search, assign, transfer'
    inputBinding:
      position: 1
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tango:0.5.7--py_0
stdout: tango_valid.out
