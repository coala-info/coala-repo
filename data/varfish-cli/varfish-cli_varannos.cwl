cwlVersion: v1.2
class: CommandLineTool
baseCommand: varfish-cli
label: varfish-cli_varannos
doc: "varfish-cli\n\nTool homepage: https://github.com/bihealth/varfish-cli"
inputs:
  - id: api_token
    type: string
    doc: API token
    inputBinding:
      position: 101
  - id: server_url
    type: string
    doc: Server URL
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varfish-cli:0.7.0--pyhdfd78af_0
stdout: varfish-cli_varannos.out
