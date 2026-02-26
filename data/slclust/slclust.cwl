cwlVersion: v1.2
class: CommandLineTool
baseCommand: slclust
label: slclust
doc: "Cluster pairs based on Jaccard coefficient.\n\nTool homepage: https://github.com/brianjohnhaas/SLCLUST"
inputs:
  - id: input_pairs
    type: File
    doc: File of pairs to cluster
    inputBinding:
      position: 1
  - id: jaccard_coefficient
    type:
      - 'null'
      - float
    doc: Jaccard coefficient threshold for clustering
    inputBinding:
      position: 102
      prefix: -j
  - id: verbosity
    type:
      - 'null'
      - string
    doc: Verbosity level ('info', 'debug')
    inputBinding:
      position: 102
      prefix: -vv
outputs:
  - id: output_clusters
    type: File
    doc: Output file for clusters
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slclust:02022010--h077b44d_6
