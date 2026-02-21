cwlVersion: v1.2
class: CommandLineTool
baseCommand: genome2tree
label: genome2tree
doc: "A tool for generating phylogenetic trees from genome sequences.\n\nTool homepage:
  https://github.com/RicoLeiser/Genome2Tree"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genome2tree:1.1.0--pyhdfd78af_0
stdout: genome2tree.out
