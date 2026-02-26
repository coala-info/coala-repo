cwlVersion: v1.2
class: CommandLineTool
baseCommand: instrain
label: instrain_inStrain
doc: "Choose one of the operations below for more detailed help. See https://instrain.readthedocs.io
  for documentation. Example: inStrain profile -h\n\nTool homepage: https://github.com/MrOlm/inStrain"
inputs:
  - id: operation
    type: string
    doc: The inStrain operation to perform. Choose one of the operations below 
      for more detailed help.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/instrain:1.10.0--pyhdfd78af_0
stdout: instrain_inStrain.out
