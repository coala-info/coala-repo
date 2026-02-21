cwlVersion: v1.2
class: CommandLineTool
baseCommand: barcode-validator
label: barcode-validator
doc: "A tool for validating barcodes. (Note: The provided text contains system error
  logs rather than help documentation, so specific arguments could not be extracted.)\n
  \nTool homepage: https://github.com/naturalis/barcode_validator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/barcode-validator:2.0.10--pyhdfd78af_0
stdout: barcode-validator.out
