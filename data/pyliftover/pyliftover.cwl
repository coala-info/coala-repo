cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyliftover
label: pyliftover
doc: "The provided text is a container execution error log and does not contain help
  information or usage instructions for the tool.\n\nTool homepage: https://github.com/konstantint/pyliftover"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyliftover:0.4.1--pyh7e72e81_0
stdout: pyliftover.out
