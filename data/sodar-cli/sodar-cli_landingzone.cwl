cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sodar-cli
  - landingzone
label: sodar-cli_landingzone
doc: "Landing zone operations\n\nTool homepage: https://github.com/bihealth/sodar-cli"
inputs:
  - id: command
    type: string
    doc: Subcommand to execute
    inputBinding:
      position: 1
  - id: create
    type:
      - 'null'
      - boolean
    doc: Create landing zone.
    inputBinding:
      position: 102
  - id: list
    type:
      - 'null'
      - boolean
    doc: List landing zones.
    inputBinding:
      position: 102
  - id: move
    type:
      - 'null'
      - boolean
    doc: Move landing zone (async).
    inputBinding:
      position: 102
  - id: retrieve
    type:
      - 'null'
      - boolean
    doc: Retrieve landing zone.
    inputBinding:
      position: 102
  - id: validate
    type:
      - 'null'
      - boolean
    doc: Validate landing zone (async).
    inputBinding:
      position: 102
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sodar-cli:0.1.0--pyhdfd78af_0
stdout: sodar-cli_landingzone.out
