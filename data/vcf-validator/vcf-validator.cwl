cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf-validator
label: vcf-validator
doc: "A tool for validating VCF (Variant Call Format) files. Note: The provided help
  text contains only system error logs and does not list specific arguments or usage
  instructions.\n\nTool homepage: https://github.com/EBIVariation/vcf-validator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf-validator:0.10.2--h7a61d87_0
stdout: vcf-validator.out
