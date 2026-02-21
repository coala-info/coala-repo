cwlVersion: v1.2
class: CommandLineTool
baseCommand: gseapy
label: gseapy
doc: "Gene Set Enrichment Analysis in Python\n\nTool homepage: https://github.com/zqfang/gseapy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gseapy:1.1.11--py39h5b94c0b_0
stdout: gseapy.out
