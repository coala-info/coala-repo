cwlVersion: v1.2
class: CommandLineTool
baseCommand: gecco
label: gecco
doc: "GECCO (Gene Cluster Prediction with Conditional Random Fields) is a tool for
  identifying biosynthetic gene clusters (BGCs) in genomic sequences.\n\nTool homepage:
  https://gecco.embl.de/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gecco:0.10.2--pyhdfd78af_0
stdout: gecco.out
