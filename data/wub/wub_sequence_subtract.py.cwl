cwlVersion: v1.2
class: CommandLineTool
baseCommand: sequence_subtract.py
label: wub_sequence_subtract.py
doc: "Filter out sequences present in the first file from the second file.\n\nTool homepage: https://github.com/nanoporetech/wub"
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
  - id: input_fastx_bait
    type: File
    doc: "First input file (default: stdin)."
    inputBinding:
      position: 100
  - id: input_fastx_target
    type: File
    doc: "Second input file."
    inputBinding:
      position: 101
  - id: output_fastx
    type:
      - 'null'
      - string
    default: "sequence_subtract.out"
    doc: "Output file (default: stdout)."
    inputBinding:
      position: 102
outputs:
  - id: subtracted_fastx
    type: File
    doc: "Sequences of the second file that are not in the first"
    outputBinding:
      glob: $(inputs.output_fastx)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
