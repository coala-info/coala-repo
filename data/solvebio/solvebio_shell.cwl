cwlVersion: v1.2
class: CommandLineTool
baseCommand: solvebio shell
label: solvebio_shell
doc: "Interactive SolveBio shell\n\nTool homepage: https://github.com/solvebio/solvebio-python"
inputs:
  - id: access_token
    type:
      - 'null'
      - string
    doc: Manually provide a SolveBio OAuth2 access token
    inputBinding:
      position: 101
      prefix: --access-token
  - id: api_host
    type:
      - 'null'
      - string
    doc: Override the default SolveBio API host
    inputBinding:
      position: 101
      prefix: --api-host
  - id: api_key
    type:
      - 'null'
      - string
    doc: Manually provide a SolveBio API key
    inputBinding:
      position: 101
      prefix: --api-key
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/solvebio:2.34.0--pyh7e72e81_0
stdout: solvebio_shell.out
