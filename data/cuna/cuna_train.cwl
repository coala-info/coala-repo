cwlVersion: v1.2
class: CommandLineTool
baseCommand: cuna_train
label: cuna_train
doc: "Train a CUNA model.\n\nTool homepage: https://github.com/iris1901/CUNA"
inputs:
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Batch size for training.
    default: 256
    inputBinding:
      position: 101
      prefix: --batch_size
  - id: dim_feedforward
    type:
      - 'null'
      - int
    doc: Dimension of BiLSTM hidden units or Transformer feedforward layers.
    default: 100
    inputBinding:
      position: 101
      prefix: --dim_feedforward
  - id: early_stopping
    type:
      - 'null'
      - int
    doc: Number of epochs to wait without improvement in validation F1 before 
      stopping. 0 to disable.
    default: 0
    inputBinding:
      position: 101
      prefix: --early_stopping
  - id: embedding_dim
    type:
      - 'null'
      - int
    doc: Size of base embedding dimension.
    default: 4
    inputBinding:
      position: 101
      prefix: --embedding_dim
  - id: embedding_type
    type:
      - 'null'
      - string
    doc: Embedding type for bases.
    default: one_hot
    inputBinding:
      position: 101
      prefix: --embedding_type
  - id: epochs
    type:
      - 'null'
      - int
    doc: Number of training epochs.
    default: 100
    inputBinding:
      position: 101
      prefix: --epochs
  - id: fc_type
    type:
      - 'null'
      - string
    doc: Type of fully connected layers used in classifier.
    default: all
    inputBinding:
      position: 101
      prefix: --fc_type
  - id: l2_coef
    type:
      - 'null'
      - float
    doc: L2 regularization coefficient.
    default: 1e-05
    inputBinding:
      position: 101
      prefix: --l2_coef
  - id: lr
    type:
      - 'null'
      - float
    doc: Learning rate.
    default: 0.0001
    inputBinding:
      position: 101
      prefix: --lr
  - id: mixed_training_dataset
    type:
      type: array
      items: File
    doc: Training dataset with mixed labels. A whitespace separated list of 
      folders containing .npz files or paths to individual .npz files.
    inputBinding:
      position: 101
      prefix: --mixed_training_dataset
  - id: model_save_path
    type: Directory
    doc: Path to save trained model checkpoints.
    inputBinding:
      position: 101
      prefix: --model_save_path
  - id: model_type
    type: string
    doc: Model architecture type.
    default: None
    inputBinding:
      position: 101
      prefix: --model_type
  - id: nhead
    type:
      - 'null'
      - int
    doc: Number of attention heads in Transformer.
    default: 4
    inputBinding:
      position: 101
      prefix: --nhead
  - id: num_fc
    type:
      - 'null'
      - int
    doc: Size of fully connected layer between encoder and classifier.
    default: 16
    inputBinding:
      position: 101
      prefix: --num_fc
  - id: num_layers
    type:
      - 'null'
      - int
    doc: Number of BiLSTM or Transformer encoder layers.
    default: 3
    inputBinding:
      position: 101
      prefix: --num_layers
  - id: pe_dim
    type:
      - 'null'
      - int
    doc: Dimension for positional encoding in Transformer.
    default: 16
    inputBinding:
      position: 101
      prefix: --pe_dim
  - id: pe_type
    type:
      - 'null'
      - string
    doc: Type of positional encoding.
    default: fixed
    inputBinding:
      position: 101
      prefix: --pe_type
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix name for the model checkpoints.
    default: model
    inputBinding:
      position: 101
      prefix: --prefix
  - id: retrain
    type:
      - 'null'
      - File
    doc: Path to a saved model checkpoint for retraining.
    default: None
    inputBinding:
      position: 101
      prefix: --retrain
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed for reproducibility.
    default: None
    inputBinding:
      position: 101
      prefix: --seed
  - id: validation_dataset
    type:
      - 'null'
      - type: array
        items: File
    doc: Validation dataset for "dataset" mode. A list of folders with .npz 
      files or paths to .npz files.
    inputBinding:
      position: 101
      prefix: --validation_dataset
  - id: validation_fraction
    type:
      - 'null'
      - float
    doc: Fraction of training dataset to use for validation when validation_type
      is "split".
    default: 0.2
    inputBinding:
      position: 101
      prefix: --validation_fraction
  - id: validation_type
    type:
      - 'null'
      - string
    doc: 'Validation strategy: "split" uses a fraction of training data, "dataset"
      uses separate validation data.'
    default: split
    inputBinding:
      position: 101
      prefix: --validation_type
  - id: weights
    type:
      - 'null'
      - string
    doc: 'Weight for positive (modified) label in loss. Options: "equal", "auto",
      or a numeric value.'
    default: equal
    inputBinding:
      position: 101
      prefix: --weights
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cuna:0.3.0--pyhdfd78af_0
stdout: cuna_train.out
