cwlVersion: v1.2
class: CommandLineTool
baseCommand: m6anet
label: m6anet_valid
doc: "m6anet: error: argument command: invalid choice: 'valid' (choose from 'dataprep',
  'inference', 'train', 'compute_norm_factors', 'convert')\n\nTool homepage: https://github.com/GoekeLab/m6anet"
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/m6anet:2.1.0--pyhdfd78af_0
stdout: m6anet_valid.out
