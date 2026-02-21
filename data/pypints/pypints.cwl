cwlVersion: v1.2
class: CommandLineTool
baseCommand: pypints
label: pypints
doc: "The provided text appears to be a container execution log rather than CLI help
  text. No arguments or descriptions could be extracted from the input.\n\nTool homepage:
  https://pints.yulab.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypints:1.2.1--pyh7e72e81_0
stdout: pypints.out
