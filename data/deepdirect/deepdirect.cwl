cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepdirect
label: deepdirect
doc: "DeepDirect is a tool for predicting DNA-protein binding affinity. (Note: The
  provided help text contains only container runtime error messages and does not list
  specific command-line arguments.)\n\nTool homepage: https://github.com/Jappy0/deepdirect"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepdirect:0.2.5--pyhdfd78af_0
stdout: deepdirect.out
