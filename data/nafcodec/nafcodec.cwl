cwlVersion: v1.2
class: CommandLineTool
baseCommand: nafcodec
label: nafcodec
doc: "The provided text does not contain help information for nafcodec; it is an error
  log indicating a failure to build or run the container due to insufficient disk
  space.\n\nTool homepage: https://github.com/althonos/nafcodec"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nafcodec:0.3.1--py310hec43fc7_1
stdout: nafcodec.out
