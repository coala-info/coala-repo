cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vcf2parquet
  - split
label: vcf2parquet_split
doc: "Convert a vcf in multiple parquet file each file contains `batch_size` record\n\
  \nTool homepage: https://github.com/natir/vcf2parquet"
inputs:
  - id: input
    type: File
    doc: Input VCF file
    inputBinding:
      position: 101
      prefix: --input
  - id: output_format
    type: string
    doc: Output format string, first {} are replace by number
    inputBinding:
      position: 101
      prefix: --output-format
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf2parquet:0.5.0--h790517f_1
stdout: vcf2parquet_split.out
