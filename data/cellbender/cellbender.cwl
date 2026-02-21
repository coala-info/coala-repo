cwlVersion: v1.2
class: CommandLineTool
baseCommand: cellbender
label: cellbender
doc: "No description available from the provided text.\n\nTool homepage: https://github.com/broadinstitute/CellBender"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cellbender:0.3.2--pyhdfd78af_0
stdout: cellbender.out
