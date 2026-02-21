cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - apptainer
  - keyserver
label: apptainer_keyserver
doc: "The 'keyserver' command allows you to manage standalone keyservers that will
  be used for retrieving cryptographic keys.\n\nTool homepage: https://github.com/apptainer/apptainer"
inputs:
  - id: command
    type:
      - 'null'
      - string
    doc: Subcommand to run (add, list, login, logout, or remove)
    inputBinding:
      position: 1
  - id: config
    type:
      - 'null'
      - File
    doc: path to the file holding keyserver configurations
    default: /user/qianghu/.apptainer/remote.yaml
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
stdout: apptainer_keyserver.out
