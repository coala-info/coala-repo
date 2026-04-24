cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - apptainer
  - registry
label: apptainer_registry
doc: "Manage authentication to OCI/Docker registries. The 'registry' command allows
  you to manage authentication to standalone OCI/Docker registries, such as 'docker://'
  or 'oras://'.\n\nTool homepage: https://github.com/apptainer/apptainer"
inputs:
  - id: subcommand
    type:
      - 'null'
      - string
    doc: The registry subcommand to run (list, login, or logout)
    inputBinding:
      position: 1
  - id: config
    type:
      - 'null'
      - File
    doc: path to the file holding registry configurations
    inputBinding:
      position: 102
      prefix: --config
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/apptainer:latest
stdout: apptainer_registry.out
