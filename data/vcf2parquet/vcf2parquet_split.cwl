cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vcf2parquet
label: vcf2parquet_split
doc: "Convert a vcf in multiple parquet file each file contains `batch_size` record\n\nTool homepage: https://github.com/natir/vcf2parquet"
inputs:
  - id: input
    type: File
    doc: Input path
    inputBinding:
      position: 1
      prefix: --input
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Batch size (default 100,000)
    inputBinding:
      position: 2
      prefix: --batch-size
  - id: compression
    type:
      - 'null'
      - string
    doc: 'Compression method (default snappy) [possible values: uncompressed, snappy,
      gzip, lzo, brotli, lz4, zstd]'
    inputBinding:
      position: 3
      prefix: --compression
  - id: read_buffer
    type:
      - 'null'
      - int
    doc: Read buffer size in bytes (default 8192)
    inputBinding:
      position: 4
      prefix: --read-buffer
  - id: info_optional
    type:
      - 'null'
      - boolean
    doc: All information fields are optional
    inputBinding:
      position: 5
      prefix: --info-optional
  - id: output_format
    type: string
    doc: Output format string, first {} are replace by number
    inputBinding:
      position: 11
      prefix: --output-format
outputs:
  - id: output
    type:
      type: array
      items: File
    doc: Output parquet files, one per batch
    outputBinding:
      glob: $(inputs.output_format.replace('{}', '*'))
arguments:
  - position: 10
    valueFrom: split
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf2parquet:0.5.0--h790517f_1
