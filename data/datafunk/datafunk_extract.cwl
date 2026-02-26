cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - datafunk
  - extract
label: datafunk_extract
doc: "Extract unannotated sequences from a FASTA file.\n\nTool homepage: https://github.com/cov-ert/datafunk"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 101
      prefix: --input.fasta
  - id: left_pad
    type: int
    doc: Number of bases to pad on the left
    inputBinding:
      position: 101
      prefix: --left-pad
  - id: right_pad
    type: int
    doc: Number of bases to pad on the right
    inputBinding:
      position: 101
      prefix: --right-pad
  - id: stdout
    type:
      - 'null'
      - boolean
    doc: Output to stdout instead of a file
    inputBinding:
      position: 101
      prefix: --stdout
outputs:
  - id: output_fasta
    type: File
    doc: Output FASTA file
    outputBinding:
      glob: $(inputs.output_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
