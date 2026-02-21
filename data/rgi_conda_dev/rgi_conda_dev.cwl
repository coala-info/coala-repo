cwlVersion: v1.2
class: CommandLineTool
baseCommand: rgi
label: rgi_conda_dev
doc: "Resistance Gene Identifier (RGI) - Prediction of resistomes from genomic data.\n
  \nTool homepage: https://card.mcmaster.ca"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rgi:6.0.5--pyh05cac1d_0
stdout: rgi_conda_dev.out
