cwlVersion: v1.2
class: CommandLineTool
baseCommand: t-coffee
label: t-coffee_t_coffee
doc: "T-Coffee is a multiple sequence alignment package. (Note: The provided help
  text contains only container runtime error messages and no tool-specific usage information.)\n
  \nTool homepage: https://github.com/cbcrg/tcoffee"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/t-coffee:13.46.2.7c9e712d--pl5321hb2a3317_0
stdout: t-coffee_t_coffee.out
