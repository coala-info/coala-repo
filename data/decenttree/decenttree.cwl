cwlVersion: v1.2
class: CommandLineTool
baseCommand: decenttree
label: decenttree
doc: "A tool for phylogenetic tree construction (Note: The provided help text contains
  only system error messages and no usage information).\n\nTool homepage: https://github.com/iqtree/decenttree"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/decenttree:1.0.0--h3f9e6b0_0
stdout: decenttree.out
