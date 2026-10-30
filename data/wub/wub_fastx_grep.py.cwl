cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastx_grep.py
label: wub_fastx_grep.py
doc: "Filter sequence files by read name.\n\nTool homepage: https://github.com/nanoporetech/wub"
inputs:
  - id: in_format
    type:
      - 'null'
      - string
    doc: "Input format (fastq)."
    inputBinding:
      position: 1
      prefix: -i
  - id: out_format
    type:
      - 'null'
      - string
    doc: "Output format (fastq)."
    inputBinding:
      position: 2
      prefix: -o
  - id: read_names
    type:
      - 'null'
      - string
    doc: "Comma separated list of read names to select."
    inputBinding:
      position: 3
      prefix: -n
  - id: input_fastx
    type: File
    doc: "Input file (default: stdin)."
    inputBinding:
      position: 100
  - id: output_fastx
    type:
      - 'null'
      - string
    default: "fastx_grep.out"
    doc: "Output file (default: stdout)."
    inputBinding:
      position: 101
outputs:
  - id: selected_fastx
    type: File
    doc: "Sequences whose names were selected"
    outputBinding:
      glob: $(inputs.output_fastx)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
