cwlVersion: v1.2
class: CommandLineTool
baseCommand: dr-disco
label: dr-disco
doc: "Discordant Read Discovery tool (Note: The provided help text contains only container
  runtime error messages and no usage information).\n\nTool homepage: https://github.com/yhoogstrate/dr-disco"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dr-disco:0.18.3--pyh086e186_0
stdout: dr-disco.out
