cwlVersion: v1.2
class: CommandLineTool
baseCommand: kipoi
label: kipoi_veff_kipoi
doc: "Kipoi model-zoo command line tool.\n\nTool homepage: https://github.com/kipoi/kipoi-veff"
inputs:
  - id: command
    type: string
    doc: 'Subcommand to run; possible commands: preproc, predict, pull, ls, list_plugins,
      info, env, test, get-example, test-source, init'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kipoi:0.8.6--pyh5e36f6f_0
stdout: kipoi_veff_kipoi.out
