cwlVersion: v1.2
class: CommandLineTool
baseCommand: mkdesigner
label: mkdesigner
doc: "The provided text is a container execution error log and does not contain help
  documentation or usage instructions for the tool. As a result, no arguments could
  be extracted.\n\nTool homepage: https://github.com/KChigira/mkdesigner/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mkdesigner:0.5.2--pyhdfd78af_0
stdout: mkdesigner.out
