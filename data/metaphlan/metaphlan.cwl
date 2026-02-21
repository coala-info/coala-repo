cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaphlan
label: metaphlan
doc: "MetaPhlAn is a computational tool for profiling the composition of microbial
  communities (bacteria, archaea and eukaryotes) from metagenomic shotgun sequencing
  data.\n\nTool homepage: https://github.com/biobakery/metaphlan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaphlan:4.2.4--pyhdfd78af_0
stdout: metaphlan.out
