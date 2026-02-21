cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - simba_pbg
  - torchbiggraph_train
label: simba_pbg_torchbiggraph_train
doc: "Train a TorchBigGraph model using SIMBA. (Note: The provided text was an error
  log and did not contain CLI help information; therefore, no arguments could be extracted.)\n
  \nTool homepage: https://github.com/pinellolab/simba_pbg"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/simba_pbg:1.2--py310h1425a21_0
stdout: simba_pbg_torchbiggraph_train.out
