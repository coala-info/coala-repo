cwlVersion: v1.2
class: CommandLineTool
baseCommand: evofold2_dfgEval
label: evofold2_dfgEval
doc: "The provided text contains system error messages related to a container runtime
  failure (no space left on device) and does not contain the actual help documentation
  for evofold2_dfgEval. As a result, no arguments could be extracted.\n\nTool homepage:
  https://github.com/jakob-skou-pedersen/phy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/evofold2:0.1--0
stdout: evofold2_dfgEval.out
