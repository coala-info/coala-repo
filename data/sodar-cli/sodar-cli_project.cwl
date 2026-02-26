cwlVersion: v1.2
class: CommandLineTool
baseCommand: sodar-cli project
label: sodar-cli_project
doc: "Manage SODAR projects.\n\nTool homepage: https://github.com/bihealth/sodar-cli"
inputs:
  - id: subcommand
    type: string
    doc: 'Subcommand to execute: list, retrieve, create, or update.'
    inputBinding:
      position: 1
  - id: create
    type:
      - 'null'
      - boolean
    doc: Create project (there is no delete!).
    inputBinding:
      position: 102
      prefix: create
  - id: list
    type:
      - 'null'
      - boolean
    doc: List Projects.
    inputBinding:
      position: 102
      prefix: list
  - id: retrieve
    type:
      - 'null'
      - boolean
    doc: Retrieve project.
    inputBinding:
      position: 102
      prefix: retrieve
  - id: update
    type:
      - 'null'
      - boolean
    doc: Update project.
    inputBinding:
      position: 102
      prefix: update
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sodar-cli:0.1.0--pyhdfd78af_0
stdout: sodar-cli_project.out
