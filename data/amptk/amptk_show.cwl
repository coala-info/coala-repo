cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - amptk
  - show
label: amptk_show
doc: "Script loops through demuxed fastq file counting occurances of barcodes, can
  optionally quality trim and recount.\n\nTool homepage: https://github.com/nextgenusfs/amptk"
inputs:
  - id: input
    type: File
    doc: Input demuxed FASTQ
    inputBinding:
      position: 101
      prefix: --input
  - id: maxee
    type:
      - 'null'
      - float
    doc: MaxEE Q-trim threshold
    inputBinding:
      position: 101
      prefix: --maxee
  - id: quality_trim
    type:
      - 'null'
      - boolean
    doc: Quality trim data
    inputBinding:
      position: 101
      prefix: --quality_trim
  - id: trunclen
    type:
      - 'null'
      - int
    doc: Read truncation length
    inputBinding:
      position: 101
      prefix: --trunclen
  - id: out_path
    type:
      - 'null'
      - string
    doc: 'Output for quality trimmed data (default:'
    inputBinding:
      position: 102
      prefix: --out
outputs:
  - id: stdout
    type: stdout
    doc: Read counts per barcode (sample) and read length summary
  - id: out
    type:
      - 'null'
      - File
    doc: Output for quality trimmed data
    outputBinding:
      glob: $(inputs.out_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
stdout: amptk_show.out
