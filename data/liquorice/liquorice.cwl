cwlVersion: v1.2
class: CommandLineTool
baseCommand: liquorice
label: liquorice
doc: "Liquorice is a tool for processing genomic data, though the provided text contains
  only system error logs and no specific help documentation.\n\nTool homepage: https://github.com/epigen/LIQUORICE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/liquorice:0.5.6--pyhdfd78af_0
stdout: liquorice.out
