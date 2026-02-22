cwlVersion: v1.2
class: CommandLineTool
baseCommand: buscolite
label: buscolite
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a container execution failure (no space
  left on device).\n\nTool homepage: https://github.com/nextgenusfs/buscolite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/buscolite:26.1.26--pyhdfd78af_0
stdout: buscolite.out
