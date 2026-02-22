cwlVersion: v1.2
class: CommandLineTool
baseCommand: confindr
label: confindr
doc: "ConFindr is a tool that can identify contamination in bacterial NGS data. (Note:
  The provided text contains system error messages and does not list CLI arguments.)\n\
  \nTool homepage: https://github.com/lowandrew/ConFindr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/confindr:0.8.2--pyhdfd78af_0
stdout: confindr.out
