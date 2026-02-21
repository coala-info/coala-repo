cwlVersion: v1.2
class: CommandLineTool
baseCommand: gadma
label: gadma
doc: "Genetic Algorithm for Demographic Model Analysis\n\nTool homepage: https://github.com/ctlab/GADMA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gadma:2.0.3--pyhdfd78af_0
stdout: gadma.out
