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
  - id: advanced
    type:
      - 'null'
      - boolean
    doc: Show advanced options for custom models
    inputBinding:
      position: 102
      prefix: --advanced
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
      - File
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
outputs:
  - id: out
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phynteny_transformer:0.1.3--pyhdfd78af_0
