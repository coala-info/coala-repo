cwlVersion: v1.2
class: CommandLineTool
baseCommand: sawfish
label: sawfish_Turn
doc: "For more information, try '--help'.\n\nTool homepage: https://github.com/PacificBiosciences/sawfish"
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
    dockerPull: quay.io/biocontainers/sawfish:2.2.1--h9ee0642_0
stdout: sawfish_Turn.out
