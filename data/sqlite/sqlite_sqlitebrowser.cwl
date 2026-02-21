cwlVersion: v1.2
class: CommandLineTool
baseCommand: sqlitebrowser
label: sqlite_sqlitebrowser
doc: "The provided text appears to be a log of a failed container build or image fetch
  operation rather than command-line help text. As a result, no specific tool arguments
  or options could be extracted from the input.\n\nTool homepage: https://github.com/sqlitebrowser/sqlitebrowser"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sqlite:3.33.0
stdout: sqlite_sqlitebrowser.out
