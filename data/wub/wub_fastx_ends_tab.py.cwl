cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastx_ends_tab.py
label: wub_fastx_ends_tab.py
doc: "Generate a tab separated file with the first and last -n bases of the sequences.\n\nTool homepage: https://github.com/nanoporetech/wub"
inputs:
  - id: in_format
    type:
      - 'null'
      - string
    doc: "Input format (fastq)."
    inputBinding:
      position: 1
      prefix: -i
  - id: nr_bases
    type:
      - 'null'
      - int
    doc: "Number of bases to take from each end (100)."
    inputBinding:
      position: 2
      prefix: -n
  - id: input_fastx
    type: File
    doc: "Input file (default: stdin)."
    inputBinding:
      position: 100
  - id: output_tsv
    type:
      - 'null'
      - string
    default: "fastx_ends_tab.tsv"
    doc: "Output file (default: stdout)."
    inputBinding:
      position: 101
outputs:
  - id: ends_tsv
    type: File
    doc: "Table with the start and end bases of each read"
    outputBinding:
      glob: $(inputs.output_tsv)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
