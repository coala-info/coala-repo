cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - grzctl
  - pruefbericht
  - submit
label: grzctl_pruefbericht_submit
doc: "Submit a Prüfbericht JSON to BfArM.\n\nTool homepage: https://github.com/BfArM-MVH/grz-tools"
inputs:
  - id: allow_redacted_tan_g
    type:
      - 'null'
      - boolean
    doc: Allow submission of a Prüfbericht with a redacted TAN.
    inputBinding:
      position: 101
      prefix: --allow-redacted-tan-g
  - id: config_file
    type:
      - 'null'
      - File
    doc: Path to config file
    inputBinding:
      position: 101
      prefix: --config-file
  - id: print_token
    type:
      - 'null'
      - boolean
    doc: Print obtained access token to stdout.
    inputBinding:
      position: 101
      prefix: --print-token
  - id: pruefbericht_file
    type: File
    doc: Path to pruefbericht file
    inputBinding:
      position: 101
      prefix: --pruefbericht-file
  - id: token
    type:
      - 'null'
      - string
    doc: Access token to try instead of requesting a new one.
    inputBinding:
      position: 101
      prefix: --token
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr
    type: stderr
    doc: Log messages of the command
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grzctl:1.4.0--pyhdfd78af_0
stdout: grzctl_pruefbericht_submit.out
stderr: grzctl_pruefbericht_submit.log
