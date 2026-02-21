cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaphlan2.py
label: metaphlan2_metaphlan2.py
doc: "MetaPhlAn is a computational tool for profiling the composition of microbial
  communities (bacterial, archaeal, eukaryotic and viral) from metagenomic shotgun
  sequencing data.\n\nTool homepage: https://bitbucket.org/biobakery/metaphlan2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaphlan2:2.96.1--py_0
stdout: metaphlan2_metaphlan2.py.out
