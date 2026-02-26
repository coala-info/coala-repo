cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kipoi
  - env
label: kipoi_env
doc: "Kipoi model-zoo command line tool\n\nTool homepage: https://github.com/kipoi/kipoi"
inputs:
  - id: command
    type: string
    doc: 'Subcommand to run; possible commands: export, create, cleanup, remove, list,
      get, get_cli, install, name'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kipoi:0.8.6--pyh5e36f6f_0
stdout: kipoi_env.out
