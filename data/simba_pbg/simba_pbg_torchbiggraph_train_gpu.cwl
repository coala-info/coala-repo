cwlVersion: v1.2
class: CommandLineTool
baseCommand: simba_pbg_torchbiggraph_train_gpu
label: simba_pbg_torchbiggraph_train_gpu
doc: "SIMBA (Single-cell Embedding Along with Feature Selection and Association) PyTorch
  BigGraph training module for GPU.\n\nTool homepage: https://github.com/pinellolab/simba_pbg"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/simba_pbg:1.2--py310h1425a21_0
stdout: simba_pbg_torchbiggraph_train_gpu.out
