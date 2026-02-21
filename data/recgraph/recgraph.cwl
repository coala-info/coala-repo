cwlVersion: v1.2
class: CommandLineTool
baseCommand: recgraph
label: recgraph
doc: "A tool for analyzing recombination graphs (Note: The provided text contains
  only container build logs and no help information; arguments could not be extracted).\n
  \nTool homepage: https://github.com/AlgoLab/RecGraph"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/recgraph:1.0.0--h7b50bb2_1
stdout: recgraph.out
