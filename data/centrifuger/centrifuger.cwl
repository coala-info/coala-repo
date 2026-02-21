cwlVersion: v1.2
class: CommandLineTool
baseCommand: centrifuger
label: centrifuger
doc: "A classifier for metagenomic sequences. (Note: The provided text contains system
  error logs regarding a failed container build and does not include the tool's help
  documentation; therefore, no arguments could be extracted.)\n\nTool homepage: https://github.com/mourisl/centrifuger"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/centrifuger:1.0.12--h077b44d_0
stdout: centrifuger.out
