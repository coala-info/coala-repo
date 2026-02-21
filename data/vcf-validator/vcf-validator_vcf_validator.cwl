cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf-validator
label: vcf-validator_vcf_validator
doc: "A tool for validating VCF (Variant Call Format) files.\n\nTool homepage: https://github.com/EBIVariation/vcf-validator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf-validator:0.10.2--h7a61d87_0
stdout: vcf-validator_vcf_validator.out
