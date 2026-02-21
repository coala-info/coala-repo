cwlVersion: v1.2
class: CommandLineTool
baseCommand: drop
label: drop
doc: "The provided text does not contain help information or usage instructions. It
  is an error log indicating a failure to build or run the container image due to
  insufficient disk space.\n\nTool homepage: https://github.com/gagneurlab/drop"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/drop:1.5.0--pyhdfd78af_1
stdout: drop.out
