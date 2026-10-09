cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
label: lyner_dist-graph
doc: "Build a threshold graph, presumes pairwise_distances.\n\nLyner commands are chained and pass one matrix from command to command, so this CWL file runs `lyner read MATRIX pairwise-distances dist-graph`.\n\nTool homepage: https://github.com/tedil/lyner"
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
  - id: pairwise_metric
    type:
      - 'null'
      - string
    doc: "Distance metric of the preceding `pairwise-distances` step (default euclidean)"
    inputBinding:
      position: 5
      prefix: --metric
  - id: threshold
    type:
      - 'null'
      - float
    doc: "Edge weight threshold (default: median weight)"
    inputBinding:
      position: 20
      prefix: --threshold
  - id: layout
    type:
      - 'null'
      - string
    doc: "Graph layout: fruchterman_reingold or kamada_kawai (default fruchterman_reingold)"
    inputBinding:
      position: 20
      prefix: --layout
  - id: cliques
    type:
      - 'null'
      - boolean
    doc: "Build the maximal clique graph"
    inputBinding:
      position: 20
      prefix: --cliques
outputs:
  - id: graph_html
    type:
      - 'null'
      - File
    doc: Interactive plotly figure of the graph
    outputBinding:
      glob: temp-plot.html
  - id: stdout
    type: stdout
    doc: "Minimum, median and maximum edge weight"
arguments:
  - position: 1
    valueFrom: read
  - position: 4
    valueFrom: pairwise-distances
  - position: 10
    valueFrom: dist-graph
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
stdout: lyner_dist-graph.out
