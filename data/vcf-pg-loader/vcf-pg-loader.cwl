cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf-pg-loader
label: vcf-pg-loader
doc: "VCF to PostgreSQL loader (Note: The provided text contains container engine
  logs and error messages rather than the tool's help documentation; therefore, no
  arguments could be extracted.)\n\nTool homepage: https://github.com/Zacharyr41/vcf-pg-loader"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf-pg-loader:0.5.4--pyhdfd78af_0
stdout: vcf-pg-loader.out
