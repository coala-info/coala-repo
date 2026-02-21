cwlVersion: v1.2
class: CommandLineTool
baseCommand: macaron
label: macaron
doc: "A tool for processing and analyzing genomic data (Note: The provided text contains
  system error logs rather than help documentation, so specific arguments could not
  be extracted).\n\nTool homepage: https://github.com/waqasuddinkhan/MACARON-GenMed-LabEx"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macaron:1.0--pyh864c0ab_1
stdout: macaron.out
