cwlVersion: v1.2
class: CommandLineTool
baseCommand: sodar-cli
label: sodar-cli_project_list
doc: "List Projects.\n\nTool homepage: https://github.com/bihealth/sodar-cli"
arguments:
  - position: 10
    valueFrom: project
  - position: 11
    valueFrom: list
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Increase verbosity.'
    inputBinding:
      position: 1
      prefix: --verbose
  - id: no_verify_ssl
    type:
      - 'null'
      - boolean
    doc: 'Disable HTTPS SSL verification'
    inputBinding:
      position: 2
      prefix: --no-verify-ssl
  - id: config
    type:
      - 'null'
      - File
    doc: 'Path to configuration file.'
    inputBinding:
      position: 3
      prefix: --config
  - id: sodar_server_url
    type:
      - 'null'
      - string
    doc: 'SODAR server URL key to use, defaults to env SODAR_SERVER_URL.'
    inputBinding:
      position: 4
      prefix: --sodar-server-url
  - id: sodar_api_token
    type:
      - 'null'
      - string
    doc: 'SODAR API token to use, defaults to env SODAR_API_TOKEN.'
    inputBinding:
      position: 5
      prefix: --sodar-api-token
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sodar-cli:0.1.0--pyhdfd78af_0
stdout: sodar-cli_project_list.out
