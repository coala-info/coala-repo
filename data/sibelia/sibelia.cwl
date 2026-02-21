cwlVersion: v1.2
class: CommandLineTool
baseCommand: sibelia
label: sibelia
doc: "No description available: The provided text is a container runtime error log,
  not CLI help text.\n\nTool homepage: https://github.com/bioinf/Sibelia"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sibelia:3.0.7--0
stdout: sibelia.out
