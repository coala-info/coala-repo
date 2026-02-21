cwlVersion: v1.2
class: CommandLineTool
baseCommand: mmvc_mmvc.jl
label: mmvc_mmvc.jl
doc: "Multi-view Model-based Clustering (Note: The provided text contains a container
  runtime error and does not include usage instructions or argument definitions).\n
  \nTool homepage: https://github.com/veg/mmvc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmvc:1.0.2--1
stdout: mmvc_mmvc.jl.out
