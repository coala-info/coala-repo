cwlVersion: v1.2
class: CommandLineTool
baseCommand: DBinit
label: daligner_DBinit
doc: "Initialize a new database for the DAZZ_DB / daligner suite.\n\nTool homepage:
  https://github.com/thegenemyers/DALIGNER"
inputs:
  - id: db_name
    type: string
    doc: The name/path of the database to be initialized
    inputBinding:
      position: 1
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/daligner:2.0.20240118--h7b50bb2_0
stdout: daligner_DBinit.out
