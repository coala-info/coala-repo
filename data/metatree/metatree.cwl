cwlVersion: v1.2
class: CommandLineTool
baseCommand: metatree
label: metatree
doc: "Metatree is a tool for phylogenetic tree analysis (Note: The provided text contains
  system error logs rather than help documentation, so specific arguments could not
  be extracted).\n\nTool homepage: https://github.com/aaronmussig/metatree"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metatree:0.0.1--py_0
stdout: metatree.out
