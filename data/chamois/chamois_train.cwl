cwlVersion: v1.2
class: CommandLineTool
baseCommand: chamois_train
label: chamois_train
doc: "Train a predictor model using feature and class tables.\n\nTool homepage: https://chamois.readthedocs.io/"
inputs:
  - id: alpha
    type:
      - 'null'
      - float
    doc: The strength of the parameters regularization.
    default: 1.0
    inputBinding:
      position: 101
      prefix: --alpha
  - id: classes
    type: File
    doc: The classes table in HDF5 format to use for training the predictor.
    inputBinding:
      position: 101
      prefix: --classes
  - id: features
    type: File
    doc: The feature table in HDF5 format to use for training the predictor.
    inputBinding:
      position: 101
      prefix: --features
  - id: min_class_groups
    type:
      - 'null'
      - int
    doc: The minimum number of groups for a class to be retained.
    default: 5
    inputBinding:
      position: 101
      prefix: --min-class-groups
  - id: min_class_occurrences
    type:
      - 'null'
      - int
    doc: The minimum of occurences for a class to be retained.
    default: 0
    inputBinding:
      position: 101
      prefix: --min-class-occurrences
  - id: min_cluster_length
    type:
      - 'null'
      - int
    doc: The nucleotide length threshold for retaining a cluster.
    default: 0
    inputBinding:
      position: 101
      prefix: --min-cluster-length
  - id: min_feature_groups
    type:
      - 'null'
      - int
    doc: The minimum number of groups for a feature to be retained.
    default: 5
    inputBinding:
      position: 101
      prefix: --min-feature-groups
  - id: min_feature_occurrences
    type:
      - 'null'
      - int
    doc: The minimum of occurences for a feature to be retained.
    default: 0
    inputBinding:
      position: 101
      prefix: --min-feature-occurrences
  - id: min_genes
    type:
      - 'null'
      - int
    doc: The gene count threshold for retaining a cluster.
    default: 0
    inputBinding:
      position: 101
      prefix: --min-genes
  - id: mismatch
    type:
      - 'null'
      - boolean
    doc: Whether to correct mismatching observations.
    default: false
    inputBinding:
      position: 101
      prefix: --mismatch
  - id: model
    type:
      - 'null'
      - string
    doc: The kind of model to train.
    default: logistic
    inputBinding:
      position: 101
      prefix: --model
  - id: variance
    type:
      - 'null'
      - float
    doc: The variance threshold for filtering features.
    default: None
    inputBinding:
      position: 101
      prefix: --variance
outputs:
  - id: output
    type: File
    doc: The path where to write the trained model in JSON format.
    outputBinding:
      glob: $(inputs.output)
  - id: metrics
    type:
      - 'null'
      - File
    doc: The path to an optional metrics file to write in DVC/JSON format.
    outputBinding:
      glob: $(inputs.metrics)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chamois:0.2.2--pyhdfd78af_0
