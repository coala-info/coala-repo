cwlVersion: v1.2
class: CommandLineTool
baseCommand: varfish-cli
label: varfish-cli_tools
doc: "Varfish CLI tool for interacting with the Varfish API.\n\nTool homepage: https://github.com/bihealth/varfish-cli"
inputs:
  - id: api_token
    type: string
    doc: API token for authentication
    inputBinding:
      position: 101
      prefix: --api-token
  - id: server_url
    type: string
    doc: URL of the Varfish server
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
stdout: varfish-cli_tools.out
