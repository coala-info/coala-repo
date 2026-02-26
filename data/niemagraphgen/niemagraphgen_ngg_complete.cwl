cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngg_complete
label: niemagraphgen_ngg_complete
doc: "NiemaGraphGen v1.0.6 (FAVITES Output Format) (32-bit) (Complete Graph)\n\nTool
  homepage: https://github.com/niemasd/NiemaGraphGen"
inputs:
  - id: num_nodes
    type: int
    doc: Number of nodes in the graph
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/niemagraphgen:1.0.6--hdbdd923_0
stdout: niemagraphgen_ngg_complete.out
