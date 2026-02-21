cwlVersion: v1.2
class: CommandLineTool
baseCommand: plassembler
label: plassembler
doc: "The provided text is a container execution error log and does not contain the
  help documentation or usage instructions for the tool. As a result, no arguments
  could be extracted.\n\nTool homepage: https://github.com/gbouras13/plassembler"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plassembler:1.8.2--pyhdfd78af_0
stdout: plassembler.out
