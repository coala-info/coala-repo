cwlVersion: v1.2
class: CommandLineTool
baseCommand: peglit
label: peglit
doc: "The provided text contains system error messages related to a failed container
  execution and does not include the tool's help documentation or usage instructions.\n\
  \nTool homepage: https://github.com/sshen8/peglit/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peglit:1.1.0--pyh7cba7a3_0
stdout: peglit.out
