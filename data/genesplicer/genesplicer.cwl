cwlVersion: v1.2
class: CommandLineTool
baseCommand: genesplicer
label: genesplicer
doc: "The provided text is an error message from a container runtime and does not
  contain help information for the genesplicer tool.\n\nTool homepage: https://github.com/ykcchong/GeneSplicer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genesplicer:1.0--1
stdout: genesplicer.out
