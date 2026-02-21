cwlVersion: v1.2
class: CommandLineTool
baseCommand: singlecell-barcodes
label: singlecell-barcodes
doc: "A tool for processing single-cell barcodes. (Note: The provided text appears
  to be a container engine error log rather than the tool's help output, so no arguments
  could be extracted.)\n\nTool homepage: https://github.com/roryk/singlecell-barcodes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/singlecell-barcodes:0.2--0
stdout: singlecell-barcodes.out
