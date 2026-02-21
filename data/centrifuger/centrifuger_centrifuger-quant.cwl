cwlVersion: v1.2
class: CommandLineTool
baseCommand: centrifuger-quant
label: centrifuger_centrifuger-quant
doc: "The provided text contains system error logs related to a container build failure
  ('no space left on device') and does not contain the help documentation for centrifuger-quant.
  As a result, no arguments could be extracted.\n\nTool homepage: https://github.com/mourisl/centrifuger"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/centrifuger:1.0.12--h077b44d_0
stdout: centrifuger_centrifuger-quant.out
