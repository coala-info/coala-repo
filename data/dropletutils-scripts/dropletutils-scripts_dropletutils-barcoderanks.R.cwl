cwlVersion: v1.2
class: CommandLineTool
baseCommand: dropletutils-barcoderanks.R
label: dropletutils-scripts_dropletutils-barcoderanks.R
doc: "A tool from the dropletutils-scripts suite for calculating barcode ranks. Note:
  The provided help text contains only system error messages regarding container execution
  and does not list specific command-line arguments.\n\nTool homepage: https://github.com/ebi-gene-expression-group/dropletutils-scripts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dropletutils-scripts:0.0.5--hdfd78af_1
stdout: dropletutils-scripts_dropletutils-barcoderanks.R.out
