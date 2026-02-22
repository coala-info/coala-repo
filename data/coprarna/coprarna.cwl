cwlVersion: v1.2
class: CommandLineTool
baseCommand: coprarna
label: coprarna
doc: "CopraRNA (Comparative Prediction of RNA-RNA Interactions) is a tool for predicting
  sRNA targets by combining evidence from multiple homologous sRNAs.\n\nTool homepage:
  https://github.com/PatrickRWright/CopraRNA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coprarna:2.1.4--hdfd78af_0
stdout: coprarna.out
