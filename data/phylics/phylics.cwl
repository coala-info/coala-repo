cwlVersion: v1.2
class: CommandLineTool
baseCommand: phylics
label: phylics
doc: "PhyLiCS (Phylogeny-based Linear Combination of Signatures) is a tool for analyzing
  mutational signatures in a phylogenetic context.\n\nTool homepage: https://github.com/bioinformatics-polito/PhyliCS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylics:1.0.7--pyhdfd78af_0
stdout: phylics.out
