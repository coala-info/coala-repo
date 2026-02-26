cwlVersion: v1.2
class: CommandLineTool
baseCommand: drprg
label: drprg_Maximum
doc: "A command-line tool for managing and processing data. This specific invocation
  seems to be for a subcommand that is not recognized.\n\nTool homepage: https://github.com/mbhall88/drprg"
inputs:
  - id: command
    type: string
    doc: The command to execute
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/drprg:0.1.1--h5076881_1
stdout: drprg_Maximum.out
