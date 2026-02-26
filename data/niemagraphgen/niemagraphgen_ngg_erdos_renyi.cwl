cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngg_erdos_renyi
label: niemagraphgen_ngg_erdos_renyi
doc: "Generates a graph using the Erdos-Renyi model.\n\nTool homepage: https://github.com/niemasd/NiemaGraphGen"
inputs:
  - id: num_nodes
    type: int
    doc: The number of nodes in the graph.
    inputBinding:
      position: 1
  - id: prob_edge_creation
    type: float
    doc: The probability of creating an edge between any two nodes.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/niemagraphgen:1.0.6--hdbdd923_0
stdout: niemagraphgen_ngg_erdos_renyi.out
