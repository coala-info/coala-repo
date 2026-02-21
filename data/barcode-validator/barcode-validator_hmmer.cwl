cwlVersion: v1.2
class: CommandLineTool
baseCommand: barcode-validator-hmmer
label: barcode-validator_hmmer
doc: "A tool for barcode validation using HMMER (Note: The provided help text contains
  only system error logs and no usage information).\n\nTool homepage: https://github.com/naturalis/barcode_validator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/barcode-validator:2.0.10--pyhdfd78af_0
stdout: barcode-validator_hmmer.out
