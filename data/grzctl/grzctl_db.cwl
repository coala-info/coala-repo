cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - grzctl
  - db
label: grzctl_db
doc: "Database operations\n\nTool homepage: https://github.com/BfArM-MVH/grz-tools"
inputs:
  - id: command
    type: string
    doc: Database command
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the command
    inputBinding:
      position: 2
  - id: config_file
    type:
      - 'null'
      - string
    doc: Path to config file
    inputBinding:
      position: 103
      prefix: --config-file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grzctl:1.4.0--pyhdfd78af_0
stdout: grzctl_db.out
