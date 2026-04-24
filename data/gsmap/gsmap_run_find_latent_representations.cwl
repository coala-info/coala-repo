cwlVersion: v1.2
class: CommandLineTool
baseCommand: gsMap run_find_latent_representations
label: gsmap_run_find_latent_representations
doc: "Find latent representations using GAT.\n\nTool homepage: https://github.com/LeonSong1995/gsMap"
inputs:
  - id: annotation
    type:
      - 'null'
      - string
    doc: Name of the annotation in adata.obs to use.
    inputBinding:
      position: 101
      prefix: --annotation
  - id: convergence_threshold
    type:
      - 'null'
      - float
    doc: Threshold for convergence.
    inputBinding:
      position: 101
      prefix: --convergence_threshold
  - id: data_layer
    type: string
    doc: "Data layer for gene expression (e.g., \"count\",\n                     \
      \   \"counts\", \"log1p\")."
    inputBinding:
      position: 101
      prefix: --data_layer
  - id: epochs
    type:
      - 'null'
      - int
    doc: Number of training epochs.
    inputBinding:
      position: 101
      prefix: --epochs
  - id: feat_hidden1
    type:
      - 'null'
      - int
    doc: Neurons in the first hidden layer.
    inputBinding:
      position: 101
      prefix: --feat_hidden1
  - id: feat_hidden2
    type:
      - 'null'
      - int
    doc: Neurons in the second hidden layer.
    inputBinding:
      position: 101
      prefix: --feat_hidden2
  - id: gat_hidden1
    type:
      - 'null'
      - int
    doc: Units in the first GAT hidden layer.
    inputBinding:
      position: 101
      prefix: --gat_hidden1
  - id: gat_hidden2
    type:
      - 'null'
      - int
    doc: Units in the second GAT hidden layer.
    inputBinding:
      position: 101
      prefix: --gat_hidden2
  - id: gat_lr
    type:
      - 'null'
      - float
    doc: Learning rate for the GAT.
    inputBinding:
      position: 101
      prefix: --gat_lr
  - id: hierarchically
    type:
      - 'null'
      - boolean
    doc: Enable hierarchical latent representation finding.
    inputBinding:
      position: 101
      prefix: --hierarchically
  - id: input_hdf5_path
    type: File
    doc: Path to the input HDF5 file.
    inputBinding:
      position: 101
      prefix: --input_hdf5_path
  - id: n_comps
    type:
      - 'null'
      - int
    doc: Number of principal components for PCA.
    inputBinding:
      position: 101
      prefix: --n_comps
  - id: n_neighbors
    type:
      - 'null'
      - int
    doc: Number of neighbors for GAT.
    inputBinding:
      position: 101
      prefix: --n_neighbors
  - id: p_drop
    type:
      - 'null'
      - float
    doc: Dropout rate.
    inputBinding:
      position: 101
      prefix: --p_drop
  - id: pearson_residuals
    type:
      - 'null'
      - boolean
    doc: Using the pearson residuals.
    inputBinding:
      position: 101
      prefix: --pearson_residuals
  - id: sample_name
    type: string
    doc: Name of the sample.
    inputBinding:
      position: 101
      prefix: --sample_name
  - id: weighted_adj
    type:
      - 'null'
      - boolean
    doc: Use weighted adjacency in GAT.
    inputBinding:
      position: 101
      prefix: --weighted_adj
  - id: workdir
    type: Directory
    doc: Path to the working directory.
    inputBinding:
      position: 101
      prefix: --workdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gsmap:1.73.7--pyhdfd78af_0
stdout: gsmap_run_find_latent_representations.out
