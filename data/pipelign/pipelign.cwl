cwlVersion: v1.2
class: CommandLineTool
baseCommand: pipelign
label: pipelign
doc: "The provided text contains system error messages related to a Singularity/Docker
  container execution failure and does not contain help text or usage information
  for the tool.\n\nTool homepage: https://github.com/asmmhossain/pipelign/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pipelign:0.2--py37_0
stdout: pipelign.out
