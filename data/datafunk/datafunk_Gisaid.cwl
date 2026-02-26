cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - datafunk
  - Gisaid
label: datafunk_Gisaid
doc: "Process GISAID sequence data\n\nTool homepage: https://github.com/cov-ert/datafunk"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file
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
    doc: Output FASTA file
    outputBinding:
      glob: $(inputs.output_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
