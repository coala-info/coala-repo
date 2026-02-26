cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - datafunk
  - pad
label: datafunk_pad
doc: "Pad an alignment with gaps\n\nTool homepage: https://github.com/cov-ert/datafunk"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA alignment file
    inputBinding:
      position: 101
      prefix: -i
  - id: left_pad
    type: int
    doc: Number of bases to pad on the left
    inputBinding:
      position: 101
  - id: right_pad
    type: int
    doc: Number of bases to pad on the right
    inputBinding:
      position: 101
  - id: stdout
    type:
      - 'null'
      - boolean
    doc: Write output to stdout instead of a file
    inputBinding:
      position: 101
outputs:
  - id: output_fasta
    type: File
    doc: Output FASTA alignment file
    outputBinding:
      glob: $(inputs.output_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
