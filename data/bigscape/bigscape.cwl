cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigscape
label: bigscape
doc: "BiG-SCAPE (Biosynthetic Gene Cluster Similarity Clustering and Alignment Engine)\n
  \nTool homepage: https://github.com/medema-group/BiG-SCAPE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bigscape:2.0.2--pyhdfd78af_0
stdout: bigscape.out
