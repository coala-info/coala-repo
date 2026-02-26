cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngg_newman_watts_strogatz
label: niemagraphgen_ngg_newman_watts_strogatz
doc: "Generates a Newman-Watts-Strogatz graph.\n\nTool homepage: https://github.com/niemasd/NiemaGraphGen"
inputs:
  - id: num_nodes
    type: int
    doc: The number of nodes in the graph.
    inputBinding:
      position: 1
  - id: lattice_degree
    type: int
    doc: The degree of the initial lattice.
    inputBinding:
      position: 2
  - id: prob_rewire
    type: float
    doc: The probability of rewiring each edge.
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/niemagraphgen:1.0.6--hdbdd923_0
stdout: niemagraphgen_ngg_newman_watts_strogatz.out
