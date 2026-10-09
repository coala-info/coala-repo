cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
label: lyner_cluster-hierarchical
doc: "Hierarchical clustering\n\nLyner commands are chained and pass one matrix from command to command, so this CWL file runs `lyner read MATRIX cluster-hierarchical show`.\n\nTool homepage: https://github.com/tedil/lyner"
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
    doc: "Linkage method: single, complete, average, weighted, centroid, median or ward (default ward)"
    inputBinding:
      position: 20
      prefix: --method
  - id: distance_metric
    type:
      - 'null'
      - string
    doc: "Distance metric, for example euclidean, cityblock, correlation or cosine (default euclidean)"
    inputBinding:
      position: 20
      prefix: --distance-metric
  - id: criterion
    type:
      - 'null'
      - string
    doc: "Cluster formation criterion: inconsistent, distance, maxclust, monocrit or maxclust_monocrit (default inconsistent)"
    inputBinding:
      position: 20
      prefix: --criterion
  - id: threshold
    type:
      - 'null'
      - float
    doc: "Threshold for the criterion (default 0.8)"
    inputBinding:
      position: 20
      prefix: --threshold
outputs:
  - id: stdout
    type: stdout
    doc: "Resulting matrix in tsv format (lyner show)"
arguments:
  - position: 1
    valueFrom: read
  - position: 10
    valueFrom: cluster-hierarchical
  - position: 100
    valueFrom: show
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
stdout: lyner_cluster-hierarchical.out
