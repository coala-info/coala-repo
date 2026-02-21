cwlVersion: v1.2
class: CommandLineTool
baseCommand: sopa
label: sopa
doc: "Spatial Omics Pipeline and Analysis (SOPA) is a tool for processing and analyzing
  spatial omics data.\n\nTool homepage: https://gustaveroussy.github.io/sopa"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sopa:2.1.11--pyhdfd78af_0
stdout: sopa.out
