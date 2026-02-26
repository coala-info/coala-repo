cwlVersion: v1.2
class: CommandLineTool
baseCommand: genomepy config
label: genomepy_config
doc: "Manage configuration\n\nTool homepage: https://github.com/vanheeringen-lab/genomepy"
inputs:
  - id: command
    type: string
    doc: Command to execute (file, show, generate)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomepy:0.16.3--pyh7e72e81_0
stdout: genomepy_config.out
