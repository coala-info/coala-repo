cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
label: lyner_cluster-agglomerative
doc: "Agglomerative clustering.\n\nLyner commands are chained and pass one matrix from command to command, so this CWL file runs `lyner read MATRIX cluster-agglomerative show`.\n\nTool homepage: https://github.com/tedil/lyner"
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
  - id: by
    type:
      - 'null'
      - string
    doc: "Comma separated combination of trend, mean, median, mad, var, ontology. Order is relevant (default trend)"
    inputBinding:
      position: 20
      prefix: --by
  - id: min_nclusters
    type:
      - 'null'
      - int
    doc: "The minimum number of clusters to build (default 3). Mutually exclusive with nclusters"
    inputBinding:
      position: 20
      prefix: --min-nclusters
  - id: max_nclusters
    type:
      - 'null'
      - int
    doc: "The maximum number of clusters to build (default 20). Mutually exclusive with nclusters"
    inputBinding:
      position: 20
      prefix: --max-nclusters
  - id: nclusters
    type:
      - 'null'
      - int
    doc: "The exact number of clusters to build. Mutually exclusive with min_nclusters and max_nclusters"
    inputBinding:
      position: 20
      prefix: --nclusters
outputs:
  - id: stdout
    type: stdout
    doc: "Resulting matrix in tsv format (lyner show)"
arguments:
  - position: 1
    valueFrom: read
  - position: 10
    valueFrom: cluster-agglomerative
  - position: 100
    valueFrom: show
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
stdout: lyner_cluster-agglomerative.out
