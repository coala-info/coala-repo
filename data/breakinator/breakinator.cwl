cwlVersion: v1.2
class: CommandLineTool
baseCommand: breakinator
label: breakinator
doc: "The provided text does not contain a description or usage information for the
  tool; it consists of system error messages related to a container execution failure
  (no space left on device).\n\nTool homepage: https://github.com/jheinz27/breakinator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/breakinator:1.1.1--h067a5f5_1
stdout: breakinator.out
