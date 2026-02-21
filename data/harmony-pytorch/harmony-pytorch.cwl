cwlVersion: v1.2
class: CommandLineTool
baseCommand: harmony-pytorch
label: harmony-pytorch
doc: "A PyTorch implementation of the Harmony algorithm for single-cell data integration.\n
  \nTool homepage: https://github.com/lilab-bcb/harmony-pytorch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/harmony-pytorch:0.1.8--pyhdfd78af_0
stdout: harmony-pytorch.out
