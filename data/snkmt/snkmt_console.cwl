cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - snkmt
  - console
label: snkmt_console
doc: "Launch the interactive console UI to monitor workflows.\n\nTool homepage: https://github.com/cademirch/snkmt"
inputs:
  - id: db_path
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --db-path
          separate: true
    doc: Path to a snkmt database. Can be specified multiple times to monitor 
      multiple databases.
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snkmt:0.2.4--pyhdfd78af_0
stdout: snkmt_console.out
