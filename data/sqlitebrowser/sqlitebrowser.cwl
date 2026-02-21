cwlVersion: v1.2
class: CommandLineTool
baseCommand: sqlitebrowser
label: sqlitebrowser
doc: "A visual tool to create, design, and edit database files compatible with SQLite.
  (Note: The provided text is an error log and does not contain help documentation;
  no arguments could be extracted.)\n\nTool homepage: https://github.com/sqlitebrowser/sqlitebrowser"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sqlitebrowser:3.8.0--0
stdout: sqlitebrowser.out
