cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
label: lyner_cluster
doc: "Clustering via k_mean / dbscan / mean_shift.\n\nLyner commands are chained and pass one matrix from command to command, so this CWL file runs `lyner read MATRIX cluster show`.\n\nTool homepage: https://github.com/tedil/lyner"
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
  - id: method
    type:
      - 'null'
      - string
    doc: "Clustering method: dbscan, k_means or mean_shift (default k_means)"
    inputBinding:
      position: 20
      prefix: --method
  - id: num_clusters
    type:
      - 'null'
      - int
    doc: "The exact number of clusters to build (default 4; used by k_means)"
    inputBinding:
      position: 20
      prefix: --num-clusters
  - id: mode_config
    type:
      - 'null'
      - string
    doc: "Extra parameters of the clustering function as key=value pairs separated by commas"
    inputBinding:
      position: 20
      prefix: --mode-config
outputs:
  - id: stdout
    type: stdout
    doc: "Resulting matrix in tsv format (lyner show)"
arguments:
  - position: 1
    valueFrom: read
  - position: 10
    valueFrom: cluster
  - position: 100
    valueFrom: show
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
stdout: lyner_cluster.out
