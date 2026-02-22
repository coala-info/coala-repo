cwlVersion: v1.2
class: CommandLineTool
baseCommand: bior_annotate
label: bior_annotate
doc: "The provided text does not contain help information or usage instructions. It
  consists of system error messages related to a failed container execution (no space
  left on device).\n\nTool homepage: https://github.com/michaelmeiners/biorAnnotateLite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bior_annotate:v2.1.1_cv3
stdout: bior_annotate.out
