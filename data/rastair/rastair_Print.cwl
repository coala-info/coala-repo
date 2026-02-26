cwlVersion: v1.2
class: CommandLineTool
baseCommand: rastair
label: rastair_Print
doc: "For more information, try '--help'.\n\nTool homepage: https://bitbucket.org/bsblabludwig/rastair/src/v0.8.2/"
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
    dockerPull: quay.io/biocontainers/rastair:2.0.0--h03e3cfe_0
stdout: rastair_Print.out
