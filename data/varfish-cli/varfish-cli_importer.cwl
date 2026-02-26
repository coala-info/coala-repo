cwlVersion: v1.2
class: CommandLineTool
baseCommand: varfish-cli
label: varfish-cli_importer
doc: "Varfish CLI importer\n\nTool homepage: https://github.com/bihealth/varfish-cli"
inputs:
  - id: api_token
    type: string
    doc: Varfish API token
    inputBinding:
      position: 101
      prefix: --api-token
  - id: server_url
    type: string
    doc: Varfish server URL
    inputBinding:
      position: 101
      prefix: --server-url
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varfish-cli:0.7.0--pyhdfd78af_0
stdout: varfish-cli_importer.out
