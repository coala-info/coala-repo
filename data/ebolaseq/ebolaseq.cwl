cwlVersion: v1.2
class: CommandLineTool
baseCommand: ebolaseq
label: ebolaseq
doc: "The provided text contains system error logs and does not include help documentation
  or usage instructions for the tool. As a result, no arguments could be extracted.\n
  \nTool homepage: https://github.com/DaanJansen94/ebolaseq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ebolaseq:0.1.6--pyhdfd78af_0
stdout: ebolaseq.out
