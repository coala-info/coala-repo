cwlVersion: v1.2
class: CommandLineTool
baseCommand: mofapy
label: mofapy
doc: "Multi-Omics Factor Analysis (MOFA) python package\n\nTool homepage: https://github.com/PMBio/MOFA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mofapy:1.2--py_0
stdout: mofapy.out
