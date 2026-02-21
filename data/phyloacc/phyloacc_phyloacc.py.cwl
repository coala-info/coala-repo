cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyloacc_phyloacc.py
label: phyloacc_phyloacc.py
doc: "PhyloAcc: A program to identify genes or elements that show accelerated evolution
  in specific lineages.\n\nTool homepage: https://github.com/phyloacc/PhyloAcc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyloacc:2.4.5--py311hab6f30d_0
stdout: phyloacc_phyloacc.py.out
