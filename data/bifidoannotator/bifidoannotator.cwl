cwlVersion: v1.2
class: CommandLineTool
baseCommand: bifidoannotator
label: bifidoannotator
doc: "BifidoAnnotator is a tool for the functional annotation of Bifidobacterium genomes.\n
  \nTool homepage: https://github.com/nicholaspucci/bifidoAnnotator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bifidoannotator:1.0.2--pyhdfd78af_0
stdout: bifidoannotator.out
