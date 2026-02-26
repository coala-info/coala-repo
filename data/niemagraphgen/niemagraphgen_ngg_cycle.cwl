cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngg_cycle
label: niemagraphgen_ngg_cycle
doc: "NiemaGraphGen v1.0.6 (FAVITES Output Format) (32-bit) (Cycle Graph)\n\nTool
  homepage: https://github.com/niemasd/NiemaGraphGen"
inputs:
  - id: num_nodes
    type: int
    doc: Number of nodes in the cycle graph
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/niemagraphgen:1.0.6--hdbdd923_0
stdout: niemagraphgen_ngg_cycle.out
