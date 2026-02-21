cwlVersion: v1.2
class: CommandLineTool
baseCommand: extract_vcf
label: extract_vcf
doc: "A tool for extracting data from VCF (Variant Call Format) files.\n\nTool homepage:
  https://github.com/moonso/extract_vcf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/extract_vcf:0.5--pyh5e36f6f_0
stdout: extract_vcf.out
