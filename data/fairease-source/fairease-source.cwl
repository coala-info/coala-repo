cwlVersion: v1.2
class: CommandLineTool
baseCommand: fairease-source
label: fairease-source
doc: "The provided text contains error logs related to container execution and does
  not include the tool's help documentation or usage instructions. As a result, no
  arguments could be extracted.\n\nTool homepage: https://github.com/fair-ease/Source"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fairease-source:1.4.6--pyhdfd78af_0
stdout: fairease-source.out
