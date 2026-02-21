cwlVersion: v1.2
class: CommandLineTool
baseCommand: genome2tree_genome2tree.py
label: genome2tree_genome2tree.py
doc: "A tool for genome-to-tree analysis (Note: The provided help text contains only
  system error messages and no usage information).\n\nTool homepage: https://github.com/RicoLeiser/Genome2Tree"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genome2tree:1.1.0--pyhdfd78af_0
stdout: genome2tree_genome2tree.py.out
