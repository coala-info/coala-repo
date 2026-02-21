cwlVersion: v1.2
class: CommandLineTool
baseCommand: immune-ml
label: immuneml_immune-ml
doc: "The provided text contains system error logs and does not include help documentation
  or usage instructions for the tool. As a result, no arguments could be extracted.\n
  \nTool homepage: https://github.com/uio-bmi/immuneML"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/immuneml:3.0.17--pyhdfd78af_0
stdout: immuneml_immune-ml.out
