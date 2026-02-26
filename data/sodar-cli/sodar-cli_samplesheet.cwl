cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sodar-cli
  - samplesheet
label: sodar-cli_samplesheet
doc: "Manage sample sheets for projects.\n\nTool homepage: https://github.com/bihealth/sodar-cli"
inputs:
  - id: command
    type: string
    doc: The subcommand to run (retrieve, import, export)
    inputBinding:
      position: 1
  - id: export
    type:
      - 'null'
      - boolean
    doc: Export ISA-tab from project.
    inputBinding:
      position: 102
  - id: import
    type:
      - 'null'
      - boolean
    doc: Import ISA-tab into project.
    inputBinding:
      position: 102
  - id: retrieve
    type:
      - 'null'
      - boolean
    doc: Retrieve sample sheet for project.
    inputBinding:
      position: 102
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sodar-cli:0.1.0--pyhdfd78af_0
stdout: sodar-cli_samplesheet.out
