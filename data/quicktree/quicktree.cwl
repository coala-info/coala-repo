cwlVersion: v1.2
class: CommandLineTool
baseCommand: quicktree
label: quicktree
doc: "QuickTree is an efficient implementation of the neighbor-joining algorithm for
  reconstruction of phylogenies. (Note: The provided help text contains only system
  logs and error messages; no arguments could be extracted from the input.)\n\nTool
  homepage: https://github.com/khowe/quicktree"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quicktree:2.5--h7b50bb2_9
stdout: quicktree.out
