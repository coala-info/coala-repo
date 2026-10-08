cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - poppunk
label: poppunk_use-model
doc: "Apply a fitted model to a reference database to restore the database files (network\
  \ and cluster assignments) (poppunk --use-model).\n\nTool homepage: https://github.com/johnlees/PopPUNK"
arguments:
  - position: 100
    valueFrom: --use-model
inputs:
  - id: ref_db
    type: Directory
    doc: Reference database folder made by --create-db (holds <name>.h5 and <name>.dists.*).
    inputBinding:
      position: 101
      prefix: --ref-db
  - id: model_dir
    type:
      - 'null'
      - Directory
    doc: Directory containing the fitted model [default = reference database directory].
    inputBinding:
      position: 101
      prefix: --model-dir
  - id: output
    type: string
    doc: Output folder (prefix for output files).
    default: poppunk_use
    inputBinding:
      position: 101
      prefix: --output
  - id: assign_subsample
    type:
      - 'null'
      - int
    doc: Number of pairwise distances in each assignment batch [default = 5000].
    inputBinding:
      position: 101
      prefix: --assign-subsample
  - id: graph_weights
    type:
      - 'null'
      - boolean
    doc: Save within-strain Euclidean distances into the graph.
    inputBinding:
      position: 101
      prefix: --graph-weights
  - id: gpu_graph
    type:
      - 'null'
      - boolean
    doc: Use a GPU when calculating networks.
    inputBinding:
      position: 101
      prefix: --gpu-graph
  - id: deviceid
    type:
      - 'null'
      - int
    doc: CUDA device ID, if using GPU [default = 0].
    inputBinding:
      position: 101
      prefix: --deviceid
  - id: no_plot
    type:
      - 'null'
      - boolean
    doc: Switch off model plotting, which can be slow for large datasets.
    inputBinding:
      position: 101
      prefix: --no-plot
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use [default = 1].
    inputBinding:
      position: 101
      prefix: --threads
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite any existing database files.
    inputBinding:
      position: 101
      prefix: --overwrite
outputs:
  - id: output_dir
    type: Directory
    doc: Output folder.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poppunk:2.7.8--py310h4d0eb5b_0
