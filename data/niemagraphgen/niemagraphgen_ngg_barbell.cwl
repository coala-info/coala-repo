cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngg_barbell
label: niemagraphgen_ngg_barbell
doc: "NiemaGraphGen v1.0.6 (FAVITES Output Format) (32-bit) (Barbell Graph)\n\nTool
  homepage: https://github.com/niemasd/NiemaGraphGen"
inputs:
  - id: num_nodes_complete
    type: int
    doc: Number of nodes in the complete graph component
    inputBinding:
      position: 1
  - id: num_nodes_path
    type: int
    doc: Number of nodes in the path graph component
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/niemagraphgen:1.0.6--hdbdd923_0
stdout: niemagraphgen_ngg_barbell.out
