cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastx_length_tab.py
label: wub_fastx_length_tab.py
doc: "Generate a tab separated file with the sequence lengths in the input file.\n\nTool homepage: https://github.com/nanoporetech/wub"
inputs:
  - id: in_format
    type:
      - 'null'
      - string
    doc: "Input format (fasta)."
    inputBinding:
      position: 1
      prefix: -i
  - id: input_fastx
    type: File
    doc: "Input file (default: stdin)."
    inputBinding:
      position: 100
  - id: output_tsv
    type:
      - 'null'
      - string
    default: "fastx_length_tab.tsv"
    doc: "Output file (default: stdout)."
    inputBinding:
      position: 101
outputs:
  - id: length_tsv
    type: File
    doc: "Table of sequence lengths"
    outputBinding:
      glob: $(inputs.output_tsv)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
