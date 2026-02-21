cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasttree
label: fasttree
doc: "FastTree infers approximately-maximum-likelihood phylogenetic trees from alignments
  of nucleotide or protein sequences.\n\nTool homepage: https://morgannprice.github.io/fasttree"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fasttree:2.2.0--h7b50bb2_1
stdout: fasttree.out
