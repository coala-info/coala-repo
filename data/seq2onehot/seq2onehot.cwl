cwlVersion: v1.2
class: CommandLineTool
baseCommand: seq2onehot
label: seq2onehot
doc: "The provided text is a system error log regarding a failed container build/extraction
  and does not contain help documentation or usage instructions for the tool 'seq2onehot'.\n
  \nTool homepage: https://github.com/akikuno/seq2onehot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seq2onehot:0.0.1--pyhfa5458b_0
stdout: seq2onehot.out
