cwlVersion: v1.2
class: CommandLineTool
baseCommand: lassensus
label: lassensus
doc: "The provided text does not contain help information or usage instructions for
  the tool; it contains container runtime log messages and a fatal error regarding
  disk space.\n\nTool homepage: https://github.com/DaanJansen94/lassensus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lassensus:0.0.5--pyhdfd78af_0
stdout: lassensus.out
