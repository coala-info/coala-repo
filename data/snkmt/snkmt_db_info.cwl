cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - snkmt
  - db
  - info
label: snkmt_db_info
doc: "Display database information and schema version.\n\nTool homepage: https://github.com/cademirch/snkmt"
inputs:
  - id: database
    type: File
    doc: "Database file (the staged file name is passed with --db-path)"
    inputBinding:
      position: 101
      prefix: --db-path
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Enable debug logging."
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Standard error (messages of snkmt are written here)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snkmt:0.2.4--pyhdfd78af_0
stdout: snkmt_db_info.out
stderr: snkmt_db_info.err
