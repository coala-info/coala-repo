cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
label: lyner_dendro
doc: "Build a dendrogram based on the results of chosen decomposition methods.\n\nLyner commands are chained and pass one matrix from command to command, so this CWL file runs `lyner read MATRIX dendro`.\n\nTool homepage: https://github.com/tedil/lyner"
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Verbose logging (global lyner option -v, written to standard error)"
    inputBinding:
      position: 0
      prefix: -v
  - id: matrix
    type: File
    doc: "Abundance or count matrix in tsv format (first column: feature names; other columns: samples), read with `lyner read`"
    inputBinding:
      position: 2
  - id: axis
    type:
      - 'null'
      - int
    doc: "Axis to cluster: 0 clusters samples, 1 clusters features (default 0)"
    inputBinding:
      position: 20
      prefix: --axis
  - id: methods
    type:
      - 'null'
      - string
    doc: "Comma separated decomposition methods: NMF, RPCA, PCA, ICA, TSNE (default PCA)"
    inputBinding:
      position: 20
      prefix: --methods
  - id: mode
    type:
      - 'null'
      - string
    doc: "each or consensus (default each)"
    inputBinding:
      position: 20
      prefix: --mode
  - id: num_components
    type:
      - 'null'
      - string
    doc: "Numbers of components to try, for example 2-6 or 2,3 (default 2-6)"
    inputBinding:
      position: 20
      prefix: --num-components
  - id: num_runs
    type:
      - 'null'
      - int
    doc: "Number of runs (default 1)"
    inputBinding:
      position: 20
      prefix: --num-runs
outputs:
  - id: stdout
    type: stdout
    doc: "Clusters found by the chosen decomposition methods"
arguments:
  - position: 1
    valueFrom: read
  - position: 10
    valueFrom: dendro
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
stdout: lyner_dendro.out
