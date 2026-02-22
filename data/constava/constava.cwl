cwlVersion: v1.2
class: CommandLineTool
baseCommand: constava
label: constava
doc: "The provided text contains system error logs and does not include the help documentation
  or usage instructions for the tool. As a result, no arguments could be extracted.\n\
  \nTool homepage: https://github.com/bio2byte/constava"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/constava:1.2.0--pyhdfd78af_0
stdout: constava.out
