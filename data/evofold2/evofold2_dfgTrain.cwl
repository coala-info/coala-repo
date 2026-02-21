cwlVersion: v1.2
class: CommandLineTool
baseCommand: evofold2_dfgTrain
label: evofold2_dfgTrain
doc: "The provided text does not contain help information for evofold2_dfgTrain. It
  contains container runtime error messages regarding a failure to build a SIF image
  due to insufficient disk space.\n\nTool homepage: https://github.com/jakob-skou-pedersen/phy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/evofold2:0.1--0
stdout: evofold2_dfgTrain.out
