cwlVersion: v1.2
class: CommandLineTool
baseCommand: spec2vec
label: spec2vec
doc: "Spec2Vec is a tool for mass spectrometry data analysis, used for calculating
  spectral similarities using word2vec-based embeddings.\n\nTool homepage: https://github.com/iomega/spec2vec"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spec2vec:0.9.1--pyhdfd78af_0
stdout: spec2vec.out
