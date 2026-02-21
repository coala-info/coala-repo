cwlVersion: v1.2
class: CommandLineTool
baseCommand: sylph-tax
label: sylph-tax
doc: "The provided text is a container runtime error log and does not contain the
  help documentation or usage instructions for the tool. As a result, no arguments
  could be extracted.\n\nTool homepage: https://github.com/bluenote-1577/sylph-tax"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sylph-tax:1.8.0--pyhdfd78af_0
stdout: sylph-tax.out
