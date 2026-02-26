cwlVersion: v1.2
class: CommandLineTool
baseCommand: oncogemini_amend
label: oncogemini_amend
doc: "Amend a database with new sample information.\n\nTool homepage: https://github.com/fakedrtom/oncogemini"
inputs:
  - id: db
    type: string
    doc: The name of the database to be amended.
    inputBinding:
      position: 1
  - id: clear
    type:
      - 'null'
      - boolean
    doc: Set all values in this column to NULL before loading.
    inputBinding:
      position: 102
      prefix: --clear
  - id: sample
    type:
      - 'null'
      - File
    doc: New sample information file to load
    inputBinding:
      position: 102
      prefix: --sample
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oncogemini:1.0.0--pyh3252c3a_0
stdout: oncogemini_amend.out
