cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - datafunk
  - duplicates
label: datafunk_duplicates
doc: "Subcommand for datafunk. The provided help text indicates 'duplicates' is an
  invalid choice, suggesting it might be a placeholder or an incorrect subcommand
  name. The valid subcommands are listed.\n\nTool homepage: https://github.com/cov-ert/datafunk"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file for pad_alignment subcommand
    inputBinding:
      position: 101
      prefix: --input.fasta
  - id: left_pad
    type: int
    doc: Left padding value for pad_alignment subcommand
    inputBinding:
      position: 101
      prefix: --left-pad
  - id: right_pad
    type: int
    doc: Right padding value for pad_alignment subcommand
    inputBinding:
      position: 101
      prefix: --right-pad
  - id: stdout
    type:
      - 'null'
      - boolean
    doc: Output to stdout for pad_alignment subcommand
    inputBinding:
      position: 101
      prefix: --stdout
outputs:
  - id: output_fasta
    type: File
    doc: Output FASTA file for pad_alignment subcommand
    outputBinding:
      glob: $(inputs.output_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
