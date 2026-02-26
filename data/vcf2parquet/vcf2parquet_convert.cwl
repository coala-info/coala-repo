cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vcf2parquet
  - convert
label: vcf2parquet_convert
doc: "Convert VCF files to Parquet format\n\nTool homepage: https://github.com/natir/vcf2parquet"
inputs:
  - id: input
    type: File
    doc: Input VCF file
    inputBinding:
      position: 101
      prefix: --input
outputs:
  - id: output
    type: File
    doc: Output Parquet file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf2parquet:0.5.0--h790517f_1
