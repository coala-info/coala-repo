cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyloaln_root_tree.py
label: phyloaln_root_tree.py
doc: "A tool for rooting phylogenetic trees (Note: The provided help text contains
  only container runtime logs and error messages, so specific arguments could not
  be extracted).\n\nTool homepage: https://github.com/huangyh45/PhyloAln"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyloaln:1.1.0--hdfd78af_0
stdout: phyloaln_root_tree.py.out
