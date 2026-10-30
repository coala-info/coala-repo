cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - add_errors.py
label: wub_add_errors.py
doc: 'Add a specified number of errors to random sites for each input sequence.


  Tool homepage: https://github.com/nanoporetech/wub'
inputs:
  - id: input_fasta
    type: File
    doc: 'Input fasta (default: stdin).'
    inputBinding:
      position: 1
  - id: output_fasta
    type:
      - 'null'
      - string
    doc: 'Output fasta (default: stdout).'
    default: add_errors.out.fasta
    inputBinding:
      position: 2
  - id: nr_errors
    type:
      - 'null'
      - int
    doc: Number of errors to introduce (0).
    inputBinding:
      position: 102
      prefix: -n
  - id: error_type
    type:
      - 'null'
      - string
    doc: 'Error type: substitution, insertion or deletion.'
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: output_fasta_file
    type: File
    doc: Fasta with errors added.
    outputBinding:
      glob: $(inputs.output_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
