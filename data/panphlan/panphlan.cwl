cwlVersion: v1.2
class: CommandLineTool
baseCommand: panphlan
label: panphlan
doc: "PanPhlAn (Pan-genome based Phylogeny and Alignment) is a tool for strain-level
  profiling of microbial communities. Note: The provided help text contains only system
  execution errors and does not list specific arguments.\n\nTool homepage: https://bitbucket.org/CibioCM/panphlan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panphlan:3.1--py_0
stdout: panphlan.out
