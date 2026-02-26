cwlVersion: v1.2
class: CommandLineTool
baseCommand: drprg
label: drprg_Download
doc: "For more information, try '--help'.\n\nTool homepage: https://github.com/mbhall88/drprg"
inputs:
  - id: command
    type: string
    doc: The command to run
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/drprg:0.1.1--h5076881_1
stdout: drprg_Download.out
