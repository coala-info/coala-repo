cwlVersion: v1.2
class: CommandLineTool
baseCommand: atol-qc-annotation
label: atol-qc-annotation
doc: "A tool for quality control and annotation (Note: The provided text contains
  system error logs rather than help documentation, so no arguments could be extracted).\n\
  \nTool homepage: https://github.com/TomHarrop/atol-qc-annotation"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atol-qc-annotation:0.1.4--pyhdfd78af_0
stdout: atol-qc-annotation.out
