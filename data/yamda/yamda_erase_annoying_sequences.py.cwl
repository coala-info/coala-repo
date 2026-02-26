cwlVersion: v1.2
class: CommandLineTool
baseCommand: erase_annoying_sequences.py
label: yamda_erase_annoying_sequences.py
doc: "Train model.\n\nTool homepage: https://github.com/daquang/YAMDA"
inputs:
  - id: input_file
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 101
      prefix: --input
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output FASTA file of negative sequences
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yamda:0.1.00e9c9d--py_0
