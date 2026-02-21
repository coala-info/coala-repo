cwlVersion: v1.2
class: CommandLineTool
baseCommand: read2tree
label: read2tree_minimap2
doc: "The provided text contains system logs and a fatal error message regarding a
  container build process rather than command-line help documentation. Consequently,
  no arguments could be extracted.\n\nTool homepage: https://github.com/DessimozLab/read2tree"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/read2tree:2.0.1--pyhdfd78af_0
stdout: read2tree_minimap2.out
