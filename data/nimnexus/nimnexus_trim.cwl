cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nimnexus
  - trim
label: nimnexus_trim
doc: "Trim the fastq reads\n\nTool homepage: https://github.com/avsecz/nimnexus"
inputs:
  - id: fastq
    type: File
    doc: Input FASTQ reads (plain text, decompress gzip files first), read from standard input
  - id: barcode
    type: string
    doc: Barcode sequences (comma-separated) that follow random barcode
    inputBinding:
      position: 1
  - id: min_keep_length
    type:
      - 'null'
      - int
    doc: Minimum number of bases required after barcode to keep read
    inputBinding:
      position: 102
      prefix: --keep
  - id: random_barcode_length
    type:
      - 'null'
      - int
    doc: Number of bases at the start of each read used for random barcode
    inputBinding:
      position: 102
      prefix: --randombarcode
  - id: trim_length
    type:
      - 'null'
      - int
    doc: Pre-trim all reads by this length before processing
    inputBinding:
      position: 102
      prefix: --trim
outputs:
  - id: trimmed_fastq
    type: stdout
    doc: Trimmed FASTQ reads
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nimnexus:0.1.1--hcb20899_3
stdin: $(inputs.fastq.path)
stdout: nimnexus_trim.fastq
