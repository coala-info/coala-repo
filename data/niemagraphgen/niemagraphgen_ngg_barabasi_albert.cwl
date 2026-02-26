cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngg_barabasi_albert
label: niemagraphgen_ngg_barabasi_albert
doc: "NiemaGraphGen v1.0.6 (FAVITES Output Format) (32-bit) (Barabasi-Albert)\n\n\
  Tool homepage: https://github.com/niemasd/NiemaGraphGen"
inputs:
  - id: num_nodes
    type: int
    doc: Number of nodes in the graph
    inputBinding:
      position: 1
  - id: num_edges_from_new
    type: int
    doc: Number of edges to add from each new node
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/niemagraphgen:1.0.6--hdbdd923_0
stdout: niemagraphgen_ngg_barabasi_albert.out
