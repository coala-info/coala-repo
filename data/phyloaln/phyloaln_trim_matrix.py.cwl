cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyloaln_trim_matrix.py
label: phyloaln_trim_matrix.py
doc: "A tool for trimming phylogenetic alignment matrices. (Note: The provided help
  text contains only container execution errors and does not list specific arguments.)\n
  \nTool homepage: https://github.com/huangyh45/PhyloAln"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyloaln:1.1.0--hdfd78af_0
stdout: phyloaln_trim_matrix.py.out
