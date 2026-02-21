cwlVersion: v1.2
class: CommandLineTool
baseCommand: onehot2seq
label: onehot2seq
doc: "The provided text does not contain help information for the tool. It contains
  error logs related to a container environment (Singularity/Apptainer) failing to
  build an image due to insufficient disk space.\n\nTool homepage: https://github.com/akikuno/onehot2seq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/onehot2seq:0.0.2--pyh086e186_1
stdout: onehot2seq.out
