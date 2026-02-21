cwlVersion: v1.2
class: CommandLineTool
baseCommand: seq2onehot_onehot2seq
label: seq2onehot_onehot2seq
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build or run a container image due to insufficient disk
  space.\n\nTool homepage: https://github.com/akikuno/seq2onehot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seq2onehot:0.0.1--pyhfa5458b_0
stdout: seq2onehot_onehot2seq.out
