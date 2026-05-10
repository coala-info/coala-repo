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
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: File
    doc: Output Parquet file
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf2parquet:0.5.0--h790517f_1
