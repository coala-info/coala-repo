cwlVersion: v1.2
class: CommandLineTool
baseCommand: polyat
label: polyat
doc: "The provided text contains container build logs and error messages rather than
  CLI help text. As a result, no arguments or tool descriptions could be extracted.\n
  \nTool homepage: https://github.com/DaanJansen94/polyat"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/polyat:0.1.2--pyhdfd78af_0
stdout: polyat.out
