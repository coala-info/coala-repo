cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyloaln_prune_tree.py
label: phyloaln_prune_tree.py
doc: "A tool for pruning phylogenetic trees. (Note: The provided help text contains
  container runtime errors and does not list specific arguments.)\n\nTool homepage:
  https://github.com/huangyh45/PhyloAln"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyloaln:1.1.0--hdfd78af_0
stdout: phyloaln_prune_tree.py.out
