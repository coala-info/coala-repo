cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - datafunk
  - Split
label: datafunk_Split
doc: "Split a fasta file into multiple files based on padding.\n\nTool homepage: https://github.com/cov-ert/datafunk"
inputs:
  - id: input_fasta
    type: File
    doc: Input fasta file
    inputBinding:
      position: 101
      prefix: -i
  - id: left_pad
    type: int
    doc: Amount to pad on the left
    inputBinding:
      position: 101
  - id: right_pad
    type: int
    doc: Amount to pad on the right
    inputBinding:
      position: 101
  - id: stdout
    type:
      - 'null'
      - boolean
    doc: Output to stdout
    inputBinding:
      position: 101
outputs:
  - id: output_fasta
    type: File
    doc: Output fasta file
    outputBinding:
      glob: $(inputs.output_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
