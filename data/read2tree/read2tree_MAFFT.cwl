cwlVersion: v1.2
class: CommandLineTool
baseCommand: read2tree
label: read2tree_MAFFT
doc: "The provided text contains system logs and error messages related to a container
  build process rather than CLI help text. As a result, no command-line arguments
  or tool descriptions could be extracted.\n\nTool homepage: https://github.com/DessimozLab/read2tree"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/read2tree:2.0.1--pyhdfd78af_0
stdout: read2tree_MAFFT.out
