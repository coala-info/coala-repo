cwlVersion: v1.2
class: CommandLineTool
baseCommand: scnic
label: scnic
doc: "SCNIC (Sparse Co-occurrence Network Investigation for Compositional data) is
  a tool for finding correlations between variables in numeric data and summarizing
  highly correlated variables.\n\nTool homepage: https://github.com/shafferm/SCNIC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scnic:0.6.6--pyhdfd78af_0
stdout: scnic.out
