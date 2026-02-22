cwlVersion: v1.2
class: CommandLineTool
baseCommand: bold-identification
label: bold-identification
doc: "A tool for BOLD (Barcode of Life Data System) identification. Note: The provided
  text contains system error logs rather than help documentation, so specific arguments
  could not be extracted.\n\nTool homepage: https://github.com/linzhi2013/bold_identification"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bold-identification:0.0.27--py_0
stdout: bold-identification.out
