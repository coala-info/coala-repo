cwlVersion: v1.2
class: CommandLineTool
baseCommand: wise2
label: wise2
doc: "The provided text is a container runtime error log and does not contain help
  documentation or usage instructions for the wise2 tool.\n\nTool homepage: https://www.ebi.ac.uk/~birney/wise2/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wise2:2.4.1--h17e8430_6
stdout: wise2.out
