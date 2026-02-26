cwlVersion: v1.2
class: CommandLineTool
baseCommand: gemini amend
label: gemini_amend
doc: "Amend a Gemini database.\n\nTool homepage: https://github.com/arq5x/gemini"
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
      - string
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
    dockerPull: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
stdout: gemini_amend.out
