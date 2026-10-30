cwlVersion: v1.2
class: CommandLineTool
baseCommand: sequence_filter.py
label: wub_sequence_filter.py
doc: "Filter sequences by length and mean quality value.\n\nTool homepage: https://github.com/nanoporetech/wub"
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
  - id: min_qual
    type:
      - 'null'
      - float
    doc: "Minimum mean quality value (0.0)."
    inputBinding:
      position: 3
      prefix: -q
  - id: min_length
    type:
      - 'null'
      - int
    doc: "Minimum length (0)."
    inputBinding:
      position: 4
      prefix: -l
  - id: revcomp
    type:
      - 'null'
      - boolean
    doc: "Reverse complement sequences."
    inputBinding:
      position: 5
      prefix: -c
  - id: max_length
    type:
      - 'null'
      - int
    doc: "Maximum length (None)."
    inputBinding:
      position: 6
      prefix: -u
  - id: input_fastx
    type: File
    doc: "Input file (default: stdin)."
    inputBinding:
      position: 100
  - id: output_fastx
    type:
      - 'null'
      - string
    default: "sequence_filter.out"
    doc: "Output file (default: stdout)."
    inputBinding:
      position: 101
outputs:
  - id: filtered_fastx
    type: File
    doc: "Filtered sequences"
    outputBinding:
      glob: $(inputs.output_fastx)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
