cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf_assembly_checker
label: vcf-validator_vcf_assembly_checker
doc: "VCF assembly checker (Note: The provided help text contained only container
  runtime errors and no usage information)\n\nTool homepage: https://github.com/EBIVariation/vcf-validator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf-validator:0.10.2--h7a61d87_0
stdout: vcf-validator_vcf_assembly_checker.out
