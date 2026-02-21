cwlVersion: v1.2
class: CommandLineTool
baseCommand: read2tree
label: read2tree
doc: "The provided text is a container runtime error log and does not contain help
  information or usage instructions for the read2tree tool. As a result, no arguments
  could be extracted.\n\nTool homepage: https://github.com/DessimozLab/read2tree"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/read2tree:2.0.1--pyhdfd78af_0
stdout: read2tree.out
