cwlVersion: v1.2
class: CommandLineTool
baseCommand: rdp-classifier
label: rdp-classifier
doc: "The RDP Classifier is a naive Bayesian classifier that can rapidly provide taxonomic
  assignments from domain to genus, with confidence estimates for each assignment.\n
  \nTool homepage: https://github.com/rdpstaff/classifier"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rdp-classifier:v2.10.2-4-deb_cv1
stdout: rdp-classifier.out
