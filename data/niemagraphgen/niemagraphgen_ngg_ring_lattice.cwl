cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngg_ring_lattice
label: niemagraphgen_ngg_ring_lattice
doc: "Generates a ring lattice graph.\n\nTool homepage: https://github.com/niemasd/NiemaGraphGen"
inputs:
  - id: num_nodes
    type: int
    doc: The number of nodes in the graph.
    inputBinding:
      position: 1
  - id: degree
    type: int
    doc: The degree of each node in the graph.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/niemagraphgen:1.0.6--hdbdd923_0
stdout: niemagraphgen_ngg_ring_lattice.out
