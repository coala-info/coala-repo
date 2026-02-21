cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepmicro_DM.py
label: deepmicro_DM.py
doc: "DeepMicro: deep learning for microbiome-based classification and regression.\n
  \nTool homepage: https://github.com/paulzierep/DeepMicro"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepmicro:1.4--pyhdfd78af_1
stdout: deepmicro_DM.py.out
