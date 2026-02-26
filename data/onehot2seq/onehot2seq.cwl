cwlVersion: v1.2
class: CommandLineTool
baseCommand: onehot2seq
label: onehot2seq
doc: "Converts one-hot encoded sequences to biological sequences.\n\nTool homepage:
  https://github.com/akikuno/onehot2seq"
inputs:
  - id: ambiguous
    type:
      - 'null'
      - boolean
    doc: Accept ambiguous characters
    inputBinding:
      position: 101
      prefix: --ambiguous
  - id: format
    type:
      - 'null'
      - string
    doc: FASTA or text file
    default: txt
    inputBinding:
      position: 101
      prefix: --format
  - id: input
    type: File
    doc: Numpy npy file
    inputBinding:
      position: 101
      prefix: --input
  - id: type
    type: string
    doc: Sequence type (DNA/RNA/Protein)
    inputBinding:
      position: 101
      prefix: --type
outputs:
  - id: output
    type: File
    doc: FASTA or text file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/onehot2seq:0.0.2--pyh086e186_1
