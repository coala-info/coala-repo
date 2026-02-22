cwlVersion: v1.2
class: CommandLineTool
baseCommand: cogclassifier
label: cogclassifier
doc: "A tool for COG (Clusters of Orthologous Groups) classification of protein sequences.\n\
  \nTool homepage: https://github.com/moshi4/COGclassifier/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cogclassifier:2.0.0--pyhdfd78af_0
stdout: cogclassifier.out
