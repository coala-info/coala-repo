cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
  - dist-graph
label: lyner_dist-graph
doc: "Generates a distance graph from a distance matrix.\n\nTool homepage: https://github.com/tedil/lyner"
inputs:
  - id: input_matrix
    type: File
    doc: Path to the input distance matrix file.
    inputBinding:
      position: 1
  - id: color_by
    type:
      - 'null'
      - string
    doc: Attribute to use for coloring nodes (e.g., cluster_id).
    inputBinding:
      position: 102
      prefix: --color-by
  - id: color_map
    type:
      - 'null'
      - string
    doc: Colormap to use for node coloring (e.g., viridis, plasma).
    inputBinding:
      position: 102
      prefix: --color-map
  - id: edge_width
    type:
      - 'null'
      - float
    doc: Width of the edges in the graph.
    inputBinding:
      position: 102
      prefix: --edge-width
  - id: iterations
    type:
      - 'null'
      - int
    doc: Maximum number of iterations for the layout algorithm.
    inputBinding:
      position: 102
      prefix: --iterations
  - id: k
    type:
      - 'null'
      - int
    doc: Parameter for the spring layout (number of iterations).
    inputBinding:
      position: 102
      prefix: --k
  - id: labels
    type:
      - 'null'
      - boolean
    doc: Whether to display node labels.
    inputBinding:
      position: 102
      prefix: --labels
  - id: layout
    type:
      - 'null'
      - string
    doc: Layout algorithm for the graph (e.g., spring, circular, spectral).
    inputBinding:
      position: 102
      prefix: --layout
  - id: no_labels
    type:
      - 'null'
      - boolean
    doc: Whether to hide node labels.
    inputBinding:
      position: 102
      prefix: --no-labels
  - id: node_size
    type:
      - 'null'
      - float
    doc: Size of the nodes in the graph.
    inputBinding:
      position: 102
      prefix: --node-size
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_graph
    type:
      - 'null'
      - File
    doc: Path to save the output graph file.
    outputBinding:
      glob: $(inputs.output_graph)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
