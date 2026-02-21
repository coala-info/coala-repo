cwlVersion: v1.2
class: CommandLineTool
baseCommand: kamino
label: kamino
doc: "The provided text is an error log from a container runtime and does not contain
  the tool's help documentation or usage instructions.\n\nTool homepage: https://github.com/rderelle/kamino"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kamino:0.6.0--h4349ce8_0
stdout: kamino.out
