cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - apptainer
  - remote
label: apptainer_remote
doc: "Manage apptainer remote endpoints through its subcommands. A 'remote endpoint'
  is a group of services compatible with the container library API.\n\nTool homepage:
  https://github.com/apptainer/apptainer"
inputs:
  - id: subcommand
    type: string
    doc: The remote subcommand to execute (add, get-login-password, list, login, logout,
      remove, status, use)
    inputBinding:
      position: 1
  - id: config
    type:
      - 'null'
      - File
    doc: path to the file holding remote endpoint configurations
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
stdout: apptainer_remote.out
