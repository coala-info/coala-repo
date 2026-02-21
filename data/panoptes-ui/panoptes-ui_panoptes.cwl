cwlVersion: v1.2
class: CommandLineTool
baseCommand: panoptes
label: panoptes-ui_panoptes
doc: "monitor computational workflows in real-time\n\nTool homepage: https://github.com/panoptes-organization/panoptes"
inputs:
  - id: ip
    type:
      - 'null'
      - string
    doc: Set the IP of the panoptes server
    default: 0.0.0.0
    inputBinding:
      position: 101
      prefix: --ip
  - id: port
    type:
      - 'null'
      - int
    doc: The port of the server
    default: 5000
    inputBinding:
      position: 101
      prefix: --port
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be Verbose
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panoptes-ui:0.2.3--pyh7cba7a3_0
stdout: panoptes-ui_panoptes.out
