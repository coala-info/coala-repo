cwlVersion: v1.2
class: CommandLineTool
baseCommand: phylophlan
label: phylophlan
doc: "PhyloPhlAn is a comprehensive pipeline for phylogenetic analysis and characterization
  of microbial genomes and metagenomes. (Note: The provided text contains system error
  messages regarding disk space and container image retrieval rather than help documentation;
  therefore, no arguments could be extracted from the input.)\n\nTool homepage: https://github.com/biobakery/phylophlan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylophlan:3.1.1--pyhdfd78af_0
stdout: phylophlan.out
