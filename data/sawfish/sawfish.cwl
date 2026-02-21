cwlVersion: v1.2
class: CommandLineTool
baseCommand: sawfish
label: sawfish
doc: "The provided text is a container execution error log and does not contain help
  documentation or argument definitions for the 'sawfish' tool.\n\nTool homepage:
  https://github.com/PacificBiosciences/sawfish"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sawfish:2.2.1--h9ee0642_0
stdout: sawfish.out
