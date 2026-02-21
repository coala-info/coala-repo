cwlVersion: v1.2
class: CommandLineTool
baseCommand: FastTreeMP
label: fasttree_FastTreeMP
doc: "FastTree infers approximately-maximum-likelihood phylogenetic trees from alignments
  of nucleotide or protein sequences. (Note: The provided help text contains only
  system error messages and no usage information.)\n\nTool homepage: https://morgannprice.github.io/fasttree"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fasttree:2.2.0--h7b50bb2_1
stdout: fasttree_FastTreeMP.out
