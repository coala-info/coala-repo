cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - annotate_length.py
label: wub_annotate_length.py
doc: 'Add sequence length to sequence record descriptions.


  Tool homepage: https://github.com/nanoporetech/wub'
inputs:
  - id: input_fastx
    type: File
    doc: 'Input file (default: stdin).'
    inputBinding:
      position: 1
  - id: output_fastx
    type:
      - 'null'
      - string
    doc: 'Output file (default: stdout).'
    default: annotate_length.out.fastq
    inputBinding:
      position: 2
  - id: in_format
    type:
      - 'null'
      - string
    doc: Input format (fastq).
    inputBinding:
      position: 102
      prefix: -i
  - id: out_format
    type:
      - 'null'
      - string
    doc: Output format (fastq).
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: output_fastx_file
    type: File
    doc: Sequence file with lengths added to the record descriptions.
    outputBinding:
      glob: $(inputs.output_fastx)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
