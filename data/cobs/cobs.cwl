cwlVersion: v1.2
class: CommandLineTool
baseCommand: cobs
label: cobs
doc: "Compact Bit-Sliced Signature Index (Note: The provided text contains container
  runtime error logs rather than tool help text, so no arguments could be extracted).\n
  \nTool homepage: https://panthema.net/cobs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cobs:0.3.1--hdcf5f25_0
stdout: cobs.out
