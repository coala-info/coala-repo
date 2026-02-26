cwlVersion: v1.2
class: CommandLineTool
baseCommand: seq2onehot
label: seq2onehot
doc: "Convert biological sequences (DNA/RNA/Protein) from FASTA format to one-hot
  encoded NumPy arrays.\n\nTool homepage: https://github.com/akikuno/seq2onehot"
inputs:
  - id: ambiguous
    type:
      - 'null'
      - boolean
    doc: Accept ambiguous characters
    inputBinding:
      position: 101
      prefix: --ambiguous
  - id: input
    type: File
    doc: FASTA or Sequence file
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
    doc: Numpy .npy format
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seq2onehot:0.0.1--pyhfa5458b_0
