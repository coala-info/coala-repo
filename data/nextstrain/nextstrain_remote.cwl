cwlVersion: v1.2
class: CommandLineTool
baseCommand: nextstrain_remote
label: nextstrain_remote
doc: "Upload, download, and manage Nextstrain files on remote sources.\n\nTool homepage:
  https://nextstrain.org"
inputs:
  - id: command
    type: string
    doc: 'The subcommand to run. Available commands: upload, download, list, ls, delete,
      rm.'
    inputBinding:
      position: 1
  - id: command_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the chosen subcommand.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextstrain:20200304--hdfd78af_1
stdout: nextstrain_remote.out
