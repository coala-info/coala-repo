cwlVersion: v1.2
class: CommandLineTool
baseCommand: tgv
label: tgv
doc: "The provided text is a container build log and does not contain the help documentation
  or usage instructions for the 'tgv' tool. As a result, no arguments could be extracted.\n
  \nTool homepage: https://github.com/zeqianli/tgv"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tgv:0.1.0--h521fa98_0
stdout: tgv.out
