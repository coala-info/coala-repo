cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf-validator
label: vcftools_vcf-validator
doc: "A tool for validating VCF (Variant Call Format) files.\n\nTool homepage: https://github.com/vcftools/vcftools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcftools:0.1.17--pl5321h077b44d_0
stdout: vcftools_vcf-validator.out
