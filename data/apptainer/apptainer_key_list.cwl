cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - apptainer
  - key
  - list
label: apptainer_key_list
doc: "List your local keys in your keyring. Will list public (trusted) keys by default.\n\nTool homepage: https://github.com/apptainer/apptainer"
inputs:
  - id: keysdir
    type:
      - 'null'
      - Directory
    doc: set local keyring dir path
    inputBinding:
      position: 1
      prefix: --keysdir
  - id: global
    type:
      - 'null'
      - boolean
    doc: manage global public keys (import/pull/remove are restricted to root user or
      unprivileged installation only)
    inputBinding:
      position: 1
      prefix: --global
  - id: secret
    type:
      - 'null'
      - boolean
    doc: list private keys instead of the default which displays public ones
    inputBinding:
      position: 1
      prefix: --secret
outputs:
  - id: stdout
    type: stdout
    doc: Key listing
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/apptainer:latest
stdout: apptainer_key_list.out
