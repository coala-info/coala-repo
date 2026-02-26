cwlVersion: v1.2
class: CommandLineTool
baseCommand: amptk-get_barcode_counts.py
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
    default: 1.0
    inputBinding:
      position: 101
      prefix: --maxee
  - id: quality_trim
    type:
      - 'null'
      - boolean
    doc: Quality trim data
    default: false
    inputBinding:
      position: 101
      prefix: --quality_trim
  - id: trunclen
    type:
      - 'null'
      - int
    doc: Read truncation length
    default: 250
    inputBinding:
      position: 101
      prefix: --trunclen
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Output for quality trimmed data
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
