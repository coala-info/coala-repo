cwlVersion: v1.2
class: CommandLineTool
baseCommand: fq_filter
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
      - string
    doc: Allowlist of record names
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
outputs:
  - id: dsts
    type: File
    doc: Filtered FASTQ destinations
    outputBinding:
      glob: $(inputs.dsts)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fq:0.12.0--h9ee0642_0
