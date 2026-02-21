cwlVersion: v1.2
class: CommandLineTool
baseCommand: poa
label: poa
doc: "Partial Order Alignment (Note: The provided text contains container build errors
  and does not include the tool's help documentation. No arguments could be extracted.)\n
  \nTool homepage: https://github.com/jakecreps/poastal"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poa:2.0--h779adbc_3
stdout: poa.out
