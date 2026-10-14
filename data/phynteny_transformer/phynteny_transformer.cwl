cwlVersion: v1.2
class: CommandLineTool
baseCommand: phynteny_transformer
label: phynteny_transformer
doc: "Phynteny Transformer\n\nTool homepage: https://github.com/susiegriggo/Phynteny_transformer"
inputs:
  - id: infile
    type: File
    doc: Input GenBank file
    inputBinding:
      position: 1
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Batch size for processing data
    inputBinding:
      position: 102
      prefix: --batch-size
  - id: confidence_threshold
    type:
      - 'null'
      - float
    doc: Confidence threshold for high-confidence predictions (0.0-1.0)
    inputBinding:
      position: 102
      prefix: --confidence-threshold
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable verbose debug logging to console
    inputBinding:
      position: 102
      prefix: --debug
  - id: esm_model
    type:
      - 'null'
      - string
    doc: Specify path to ESM model if not the default
    inputBinding:
      position: 102
      prefix: --esm_model
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite output directory
    inputBinding:
      position: 102
      prefix: --force
  - id: models
    type:
      - 'null'
      - Directory
    doc: Path to the models to use for predictions
    inputBinding:
      position: 102
      prefix: --models
  - id: prefix
    type:
      - 'null'
      - string
    doc: Output prefix
    inputBinding:
      position: 102
      prefix: --prefix
  - id: save_attention_weights
    type:
      - 'null'
      - boolean
    doc: Save attention weight matrices to files during prediction. Attention 
      weights will be saved as pickle files in the output directory under 
      'attention_weights/' folder. Each genome will have its own file containing
      attention weights from all models.
    inputBinding:
      position: 102
      prefix: --save-attention-weights
  - id: show_model_info
    type:
      - 'null'
      - boolean
    doc: Display detailed information about the model architecture including 
      parameter counts and exit
    inputBinding:
      position: 102
      prefix: --show-model-info
  - id: input_dim
    type:
      - 'null'
      - int
    doc: Input dimension for the model (advanced model option)
    inputBinding:
      position: 102
      prefix: --input-dim
  - id: num_classes
    type:
      - 'null'
      - int
    doc: Number of output classes (advanced model option)
    inputBinding:
      position: 102
      prefix: --num-classes
  - id: num_heads
    type:
      - 'null'
      - int
    doc: Number of attention heads (advanced model option)
    inputBinding:
      position: 102
      prefix: --num-heads
  - id: hidden_dim
    type:
      - 'null'
      - int
    doc: Hidden dimension (advanced model option)
    inputBinding:
      position: 102
      prefix: --hidden-dim
  - id: lstm_hidden_dim
    type:
      - 'null'
      - int
    doc: LSTM hidden dimension (advanced model option)
    inputBinding:
      position: 102
      prefix: --lstm-hidden-dim
  - id: no_lstm
    type:
      - 'null'
      - boolean
    doc: Do not use the LSTM layer (advanced model option)
    inputBinding:
      position: 102
      prefix: --no-lstm
  - id: max_len
    type:
      - 'null'
      - int
    doc: Maximum number of genes in a genome (advanced model option)
    inputBinding:
      position: 102
      prefix: --max-len
  - id: protein_dropout_rate
    type:
      - 'null'
      - float
    doc: Protein dropout rate (advanced model option)
    inputBinding:
      position: 102
      prefix: --protein-dropout-rate
  - id: attention
    type:
      - 'null'
      - type: enum
        symbols: [absolute,relative,circular]
    doc: Attention type (advanced model option)
    inputBinding:
      position: 102
      prefix: --attention
  - id: positional_encoding_type
    type:
      - 'null'
      - type: enum
        symbols: [fourier,sinusoidal]
    doc: Positional encoding type (advanced model option)
    inputBinding:
      position: 102
      prefix: --positional-encoding-type
  - id: pre_norm
    type:
      - 'null'
      - boolean
    doc: Use pre-layer normalisation (advanced model option)
    inputBinding:
      position: 102
      prefix: --pre-norm
  - id: progressive_dropout
    type:
      - 'null'
      - boolean
    doc: Use progressive dropout (advanced model option)
    inputBinding:
      position: 102
      prefix: --progressive-dropout
  - id: initial_dropout_rate
    type:
      - 'null'
      - float
    doc: Initial dropout rate (advanced model option)
    inputBinding:
      position: 102
      prefix: --initial-dropout-rate
  - id: final_dropout_rate
    type:
      - 'null'
      - float
    doc: Final dropout rate (advanced model option)
    inputBinding:
      position: 102
      prefix: --final-dropout-rate
  - id: output_dim
    type:
      - 'null'
      - int
    doc: Output dimension (advanced model option)
    inputBinding:
      position: 102
      prefix: --output-dim
  - id: num_layers
    type:
      - 'null'
      - int
    doc: Number of layers (advanced model option)
    inputBinding:
      position: 102
      prefix: --num-layers
  - id: dropout
    type:
      - 'null'
      - float
    doc: Dropout rate (advanced model option)
    inputBinding:
      position: 102
      prefix: --dropout
  - id: out_path
    type: string
    doc: Output directory
    inputBinding:
      position: 103
      prefix: --out
outputs:
  - id: out
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.out_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phynteny_transformer:0.1.3--pyhdfd78af_0
