cwlVersion: v1.2
class: CommandLineTool
baseCommand: im2deep
label: im2deep
doc: "IM2Deep: Predict CCS values for peptides using deep learning.\n\nIM2Deep predicts
  Collisional Cross Section (CCS) values for peptides, including those with
  post-translational modifications. The tool supports both single-conformer and
  multi-conformer predictions with optional calibration using reference
  datasets.\n\nTool homepage: https://github.com/compomics/im2deep"
inputs:
  - id: input_file
    type: File
    doc: "CSV file with columns: seq (peptide sequence), modifications (format
      \"position|name\", can be empty) and charge. For calibration files, an
      additional 'CCS' column with observed values is required."
    inputBinding:
      position: 1
  - id: calibration_file
    type:
      - 'null'
      - File
    doc: Path to calibration file with known CCS values. Highly recommended for
      accurate predictions.
    inputBinding:
      position: 101
      prefix: --calibration-file
  - id: output_file
    type:
      - 'null'
      - string
    doc: Output file path. If not specified, creates file next to input with
      '_IM2Deep-predictions.csv' suffix.
    inputBinding:
      position: 101
      prefix: --output-file
  - id: model_name
    type:
      - 'null'
      - string
    doc: Neural network model to use for prediction (tims).
    inputBinding:
      position: 101
      prefix: --model-name
  - id: multi
    type:
      - 'null'
      - boolean
    doc: "Enable multi-conformer prediction. Requires optional dependencies: pip
      install 'im2deep[er]'"
    inputBinding:
      position: 101
      prefix: --multi
  - id: log_level
    type:
      - 'null'
      - string
    doc: Set logging verbosity level (debug, info, warning, error, critical).
    inputBinding:
      position: 101
      prefix: --log-level
  - id: n_jobs
    type:
      - 'null'
      - int
    doc: Number of parallel jobs for model inference. Default uses all
      available CPU cores.
    inputBinding:
      position: 101
      prefix: --n-jobs
  - id: calibrate_per_charge
    type:
      - 'null'
      - boolean
    doc: Apply calibration per charge state for improved accuracy. Disable for
      global calibration.
    inputBinding:
      position: 101
      prefix: --calibrate-per-charge
      valueFrom: "$(self ? 'True' : 'False')"
  - id: use_charge_state
    type:
      - 'null'
      - int
    doc: Charge state for global calibration when --calibrate-per-charge is
      disabled (1 to 6).
    inputBinding:
      position: 101
      prefix: --use-charge-state
  - id: use_single_model
    type:
      - 'null'
      - boolean
    doc: Use single model (faster) vs ensemble of models (potentially slightly
      more accurate).
    inputBinding:
      position: 101
      prefix: --use-single-model
      valueFrom: "$(self ? 'True' : 'False')"
  - id: ion_mobility
    type:
      - 'null'
      - boolean
    doc: Output ion mobility (1/K0) instead of CCS values.
    inputBinding:
      position: 101
      prefix: --ion-mobility
outputs:
  - id: predictions
    type:
      - 'null'
      - File
    doc: Predicted CCS values (CSV).
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/im2deep:1.2.0--pyhdfd78af_0
