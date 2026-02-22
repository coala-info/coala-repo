cwlVersion: v1.2
class: CommandLineTool
baseCommand: phylotools
label: phylotools
doc: "A tool for phylogenetic analysis. Note: The provided text contains system error
  messages regarding container execution and does not include specific command-line
  argument definitions.\n\nTool homepage: https://github.com/afiore6/biosql-phylotools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/phylotools:v0.2.4_cv1
stdout: phylotools.out
