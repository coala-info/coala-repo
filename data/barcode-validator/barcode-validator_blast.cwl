cwlVersion: v1.2
class: CommandLineTool
baseCommand: barcode-validator_blast
label: barcode-validator_blast
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system error logs related to a failed container image extraction
  (no space left on device).\n\nTool homepage: https://github.com/naturalis/barcode_validator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/barcode-validator:2.0.10--pyhdfd78af_0
stdout: barcode-validator_blast.out
