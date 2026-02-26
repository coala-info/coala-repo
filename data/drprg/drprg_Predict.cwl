cwlVersion: v1.2
class: CommandLineTool
baseCommand: drprg
label: drprg_Predict
doc: "Command-line tool for running various prediction tasks.\n\nTool homepage: https://github.com/mbhall88/drprg"
inputs:
  - id: command
    type: string
    doc: The command to execute. Use 'predict' for prediction tasks.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/drprg:0.1.1--h5076881_1
stdout: drprg_Predict.out
