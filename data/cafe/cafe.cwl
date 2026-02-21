cwlVersion: v1.2
class: CommandLineTool
baseCommand: cafe
label: cafe
doc: "Computational Analysis of gene Family Evolution (CAFE)\n\nTool homepage: https://hahnlab.github.io/CAFE/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cafe:5.1.0--h5ca1c30_1
stdout: cafe.out
