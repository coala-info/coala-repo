cwlVersion: v1.2
class: CommandLineTool
baseCommand: chamois_cv
label: chamois_cv
doc: "Train a predictor and evaluate it using cross-validation.\n\nTool homepage:
  https://chamois.readthedocs.io/"
inputs:
  - id: alpha
    type:
      - 'null'
      - float
    doc: The strength of the parameters regularization.
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
  - id: kfolds
    type:
      - 'null'
      - int
    doc: The number of cross-validation folds to run.
    inputBinding:
      position: 101
      prefix: --kfolds
  - id: min_class_groups
    type:
      - 'null'
      - int
    doc: The minimum number of groups for a class to be retained.
    inputBinding:
      position: 101
      prefix: --min-class-groups
  - id: min_class_occurrences
    type:
      - 'null'
      - int
    doc: The minimum of occurences for a class to be retained.
    inputBinding:
      position: 101
      prefix: --min-class-occurrences
  - id: min_cluster_length
    type:
      - 'null'
      - int
    doc: The nucleotide length threshold for retaining a cluster.
    inputBinding:
      position: 101
      prefix: --min-cluster-length
  - id: min_feature_groups
    type:
      - 'null'
      - int
    doc: The minimum number of groups for a feature to be retained.
    inputBinding:
      position: 101
      prefix: --min-feature-groups
  - id: min_feature_occurrences
    type:
      - 'null'
      - int
    doc: The minimum of occurences for a feature to be retained.
    inputBinding:
      position: 101
      prefix: --min-feature-occurrences
  - id: min_genes
    type:
      - 'null'
      - int
    doc: The gene count threshold for retaining a cluster.
    inputBinding:
      position: 101
      prefix: --min-genes
  - id: mismatch
    type:
      - 'null'
      - boolean
    doc: Whether to correct mismatching observations.
    inputBinding:
      position: 101
      prefix: --mismatch
  - id: model
    type:
      - 'null'
      - string
    doc: The kind of model to train.
    inputBinding:
      position: 101
      prefix: --model
  - id: sampling
    type:
      - 'null'
      - string
    doc: The algorithm to use for partitioning folds.
    inputBinding:
      position: 101
      prefix: --sampling
  - id: variance
    type:
      - 'null'
      - float
    doc: The variance threshold for filtering features.
    inputBinding:
      position: 101
      prefix: --variance
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: The path where to write the probabilities for each test fold.
    outputBinding:
      glob: $(inputs.output)
  - id: metrics
    type:
      - 'null'
      - File
    doc: The path to an optional metrics file to write in DVC/JSON format.
    outputBinding:
      glob: $(inputs.metrics)
  - id: report
    type:
      - 'null'
      - File
    doc: An optional file where to generate a label-wise evaluation report.
    outputBinding:
      glob: $(inputs.report)
  - id: best_model
    type:
      - 'null'
      - File
    doc: An optional file where to write the model with highest 
      macro-average-precision.
    outputBinding:
      glob: $(inputs.best_model)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chamois:0.2.2--pyhdfd78af_0
