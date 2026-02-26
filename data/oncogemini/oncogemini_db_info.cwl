cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - oncogemini
  - db_info
label: oncogemini_db_info
doc: "Show information about a specific database.\n\nTool homepage: https://github.com/fakedrtom/oncogemini"
inputs:
  - id: db
    type: string
    doc: The name of the database to be updated.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oncogemini:1.0.0--pyh3252c3a_0
stdout: oncogemini_db_info.out
