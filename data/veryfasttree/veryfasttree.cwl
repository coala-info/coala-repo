cwlVersion: v1.2
class: CommandLineTool
baseCommand: veryfasttree
label: veryfasttree
doc: "VeryFastTree is a highly optimized implementation of the FastTree method for
  large-scale phylogenetic tree reconstruction.\n\nTool homepage: https://github.com/citiususc/veryfasttree"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/veryfasttree:4.0.5--h9948957_0
stdout: veryfasttree.out
