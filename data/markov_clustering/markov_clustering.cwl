cwlVersion: v1.2
class: CommandLineTool
baseCommand: markov_clustering
label: markov_clustering
doc: "Markov Clustering (MCL) algorithm for graphs.\n\nTool homepage: https://github.com/GuyAllard/markov_clustering"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/markov_clustering:0.0.6--py_0
stdout: markov_clustering.out
