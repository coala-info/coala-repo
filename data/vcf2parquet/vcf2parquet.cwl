cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf2parquet
label: vcf2parquet
doc: "A tool to convert VCF (Variant Call Format) files to Apache Parquet format.\n
  \nTool homepage: https://github.com/natir/vcf2parquet"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf2parquet:0.5.0--h790517f_1
stdout: vcf2parquet.out
