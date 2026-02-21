cwlVersion: v1.2
class: CommandLineTool
baseCommand: onehot2seq_seq2onehot
label: onehot2seq_seq2onehot
doc: "A tool for converting between one-hot encoded data and sequences. (Note: The
  provided text contained only system error logs and no help documentation; no arguments
  could be extracted.)\n\nTool homepage: https://github.com/akikuno/onehot2seq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/onehot2seq:0.0.2--pyh086e186_1
stdout: onehot2seq_seq2onehot.out
