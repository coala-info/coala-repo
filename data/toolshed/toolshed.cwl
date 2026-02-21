cwlVersion: v1.2
class: CommandLineTool
baseCommand: toolshed
label: toolshed
doc: "The provided text contains execution logs and error messages rather than command-line
  help documentation. As a result, no arguments or tool descriptions could be extracted.\n
  \nTool homepage: https://github.com/elixir-toolshed/toolshed"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/toolshed:0.4.6--py35_0
stdout: toolshed.out
