cwlVersion: v1.2
class: CommandLineTool
baseCommand: reverse_fastq.py
label: wub_reverse_fastq.py
doc: "Reverse (but not complement!) sequences and qualities in fastq file.\n\nTool homepage: https://github.com/nanoporetech/wub"
inputs:
  - id: input_fastq
    type: File
    doc: "Input fastq (default: stdin)."
    inputBinding:
      position: 100
  - id: output_fastq
    type:
      - 'null'
      - string
    default: "reverse_fastq.fastq"
    doc: "Output fastq (default: stdout)"
    inputBinding:
      position: 101
outputs:
  - id: reversed_fastq
    type: File
    doc: "Reversed fastq"
    outputBinding:
      glob: $(inputs.output_fastq)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
