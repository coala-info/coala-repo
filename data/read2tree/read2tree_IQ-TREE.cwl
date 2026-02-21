cwlVersion: v1.2
class: CommandLineTool
baseCommand: read2tree
label: read2tree_IQ-TREE
doc: "Read2Tree: phylogenomics directly from reads. (Note: The provided help text
  contains system error logs and does not list command-line arguments.)\n\nTool homepage:
  https://github.com/DessimozLab/read2tree"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/read2tree:2.0.1--pyhdfd78af_0
stdout: read2tree_IQ-TREE.out
