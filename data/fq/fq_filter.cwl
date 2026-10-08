cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fq
  - filter
label: fq_filter
doc: "Filters a FASTQ file\n\nTool homepage: https://github.com/stjude-rust-labs/fq"
inputs:
  - id: srcs
    type:
      - 'null'
      - type: array
        items: File
    doc: FASTQ sources
    inputBinding:
      position: 1
  - id: names
    type:
      - 'null'
      - File
    doc: Allowlist of record names (one per line)
    inputBinding:
      position: 102
      prefix: --names
  - id: sequence_pattern
    type:
      - 'null'
      - string
    doc: Keep records that have sequences that match the given regular 
      expression
    inputBinding:
      position: 102
      prefix: --sequence-pattern
  - id: dsts_path
    type:
      type: array
      items: string
      inputBinding:
        prefix: --dsts
    doc: Filtered FASTQ destinations, one per source (output is gzipped if the name ends in .gz)
    inputBinding:
      position: 103
outputs:
  - id: dsts
    type:
      type: array
      items: File
    doc: Filtered FASTQ files
    outputBinding:
      glob: $(inputs.dsts_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fq:0.12.0--h9ee0642_0
