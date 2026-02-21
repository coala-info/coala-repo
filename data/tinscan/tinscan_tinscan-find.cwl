cwlVersion: v1.2
class: CommandLineTool
baseCommand: tinscan-find
label: tinscan_tinscan-find
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a container runtime error log.\n\nTool homepage: https://github.com/Adamtaranto/TE-insertion-scanner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinscan:0.2.1--pyhdfd78af_0
stdout: tinscan_tinscan-find.out
